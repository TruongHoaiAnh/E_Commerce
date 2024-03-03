using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using AspNetCoreHero.ToastNotification.Abstractions;
using App.Extension;
using App.Model;
using App.ModelViews;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace App.Controllers
{
    public class ShoppingCartController : Controller
    {
        private readonly ECommerceContext _context;
        public INotyfService _Inotiyfyservice { get; }

        public ShoppingCartController(ECommerceContext context, INotyfService notyfService)
        {
            _context = context;
            _Inotiyfyservice = notyfService;
        }

        //Tạo giỏ hàng
        //Nếu có thì lấy giỏ hàng củ ra
        //Nếu chưa có thì tạo mới một giỏ hàng rỗng
        public List<CartCartItem> Cart
        {
            get
            {
                //Cài đặt SessionExtensions để sử dụng 
                var cart = HttpContext.Session.Get<List<CartCartItem>>("Cart");
                if (cart == default(List<CartCartItem>))
                {
                    cart = new List<CartCartItem>();
                }
                return cart;
            }
        }


        [HttpPost]
        [Route("api/cart/add")]
        public IActionResult AddToCart(string IdProItem, int? Amount)
        {
            List<CartCartItem> cart = Cart;

            try
            {
                //Thêm sp vào giỏ hàng
                CartCartItem item = Cart.SingleOrDefault(p => p.cartItem.IdProItem == IdProItem);
                //Đã có cập nhật số lượng
                if (item != null)
                {
                    item.amount = item.amount + Amount.Value;
                    //Lưu lại session
                    HttpContext.Session.Set<List<CartCartItem>>("Cart", cart);
                }
                else
                {
                    var query = from p in _context.Products
                            join c in _context.Categories on p.IdCate equals c.IdCate
                            join pI in _context.ProductItems on p.IdPro equals pI.IdPro
                            where pI.IdProItem == IdProItem// Filter by product Id
                            select new
                            {
                                Product = p,
                                ProductItem = pI,
                                Category = c
                            };

                //Lấy ra một object
                var result = query.FirstOrDefault(); // Get the first or default item
                // if (product == null)
                // {
                //     return RedirectToAction("Index");
                // }

                var product = new ProCateProItemViewModel
                {
                    products = result.Product,
                    productItems = result.ProductItem,
                    categories = result.Category
                };

                    item = new CartCartItem
                    {
                        product = product,
                        amount = Amount.HasValue ? Amount.Value : 1
                    };

                    //

                    cart.Add(item);

                }

                //Lưu lại session
                // HttpContext.Session.Set<List<CartCartItem>>("Cart", cart);
                _Inotiyfyservice.Success("Add product successfully", 2);
                return Json(new { success = true });
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return Json(new { success = false });
            }
        }


        [HttpPost]
        [Route("api/cart/remove")]
        public IActionResult Remove(string IdProItem)
        {

            try
            {
                List<CartCartItem> cart = Cart;
                //Thêm sp vào giỏ hàng
                CartCartItem item = Cart.SingleOrDefault(p => p.cartItem.IdProItem == IdProItem);
                //Đã có cập nhật số lượng
                if (item != null)
                {
                    cart.Remove(item);
                }

                //Lưu lại session
                HttpContext.Session.Set<List<CartCartItem>>("Cart", cart);
                return Json(new { success = true });
            }
            catch
            {
                return Json(new { success = false });
            }
        }


        [Route("cart.html", Name = "Cart")]
        public IActionResult Index()
        {
            var lsProduct = Cart;
            return View(Cart);
        }


    }
}