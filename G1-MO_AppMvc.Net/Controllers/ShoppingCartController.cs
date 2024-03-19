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
using App.Models;
using Microsoft.AspNetCore.Identity;
using Newtonsoft.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authorization;
using System.Text.Json.Serialization;
using System.Text.Json;

namespace App.Controllers
{
    [RedirectAdmin]

    public class ShoppingCartController : Controller
    {
        private readonly E_CommerceContext _context;
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        public INotyfService _Inotiyfyservice { get; }

        public ShoppingCartController(E_CommerceContext context, INotyfService notyfService, SignInManager<AppUser> signInManager, UserManager<AppUser> userManager)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _context = context;
            _Inotiyfyservice = notyfService;
        }

        //Tạo giỏ hàng
        //Nếu có thì lấy giỏ hàng củ ra
        //Nếu chưa có thì tạo mới một giỏ hàng rỗng


        public string GenerateNextCartId()
        {
            // Retrieve the maximum existing Id_pro
            string maxIdAcc = _context.ShoppingCarts
                .Select(p => p.IdCart)
                .OrderByDescending(id => id)
                .FirstOrDefault();

            // Generate the next Id_pro
            int nextNumber = 1;
            if (!string.IsNullOrEmpty(maxIdAcc))
            {
                string numericPart = maxIdAcc.Substring(2); // Extract numeric part
                if (int.TryParse(numericPart, out int numericValue))
                {
                    nextNumber = numericValue + 1;
                }
            }

            string nextIdAcc = $"CA{nextNumber:D3}"; // Format the new Id_acc

            return nextIdAcc;
        }
        public string GenerateNextCartItemId()
        {
            // Retrieve the maximum existing Id_pro
            string maxIdAcc = _context.ShoppingCartItems
                .Select(p => p.IdCartItem)
                .OrderByDescending(id => id)
                .FirstOrDefault();

            // Generate the next Id_pro
            int nextNumber = 1;
            if (!string.IsNullOrEmpty(maxIdAcc))
            {
                string numericPart = maxIdAcc.Substring(2); // Extract numeric part
                if (int.TryParse(numericPart, out int numericValue))
                {
                    nextNumber = numericValue + 1;
                }
            }

            string nextIdAcc = $"CI{nextNumber:D3}"; // Format the new Id_acc

            return nextIdAcc;
        }


        public List<ShoppingCartItem> Cart
        {
            get
            {
                // Sử dụng SessionExtensions để lấy danh sách sản phẩm từ session
                var cart = HttpContext.Session.Get<List<ShoppingCartItem>>("Cart");

                // Kiểm tra nếu giỏ hàng trong session không tồn tại
                // hoặc là một giỏ hàng mới được tạo, nếu không, trả về giỏ hàng từ session
                if (cart == null)
                {
                    // Tạo một danh sách mới nếu giỏ hàng không tồn tại trong session
                    cart = new List<ShoppingCartItem>();
                }

                // Trả về danh sách sản phẩm trong giỏ hàng
                return cart;
            }
        }





        [HttpPost]
        [Route("api/cart/add")]

        public ActionResult AddToCart(string idProduct, string idProductItem, int quantity, float price)
        {
            try
            {
                if (idProductItem == null)
                {
                    _Inotiyfyservice.Error("Please select a category!", 3);
                    return Json(new { success = true });
                }
                //List<ShoppingCartItem> cartItem = Cart;
                string userId = _userManager.GetUserId(User);
                if (userId != null)
                {
                    // Lấy ID của người dùng đang đăng nhập
                    string idCartNew = null;
                    // Kiểm tra xem giỏ hàng đã tồn tại trong cơ sở dữ liệu chưa, nếu chưa tạo mới
                    ShoppingCart cart = _context.ShoppingCarts.SingleOrDefault(c => c.IdAcc == userId); // Thay "default" bằng id_acc của người dùng đăng nhập nếu có
                    if (cart == null)
                    {
                        idCartNew = GenerateNextCartId();
                        cart = new ShoppingCart { IdCart = idCartNew, IdAcc = userId }; // Thay "default" bằng id_acc của người dùng đăng nhập nếu có
                        _context.ShoppingCarts.Add(cart);
                        _context.SaveChanges();
                    }
                    else
                    {
                        idCartNew = cart.IdCart;
                    }

                    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                    ShoppingCartItem existingItem = _context.ShoppingCartItems.FirstOrDefault(item => item.IdProItem == idProductItem && item.IdCart == idCartNew);
                    ShoppingCartItem cartExit = cart.ShoppingCartItems.FirstOrDefault(item => item.IdProItem == idProductItem && item.IdCart == idCartNew);
                    if (existingItem != null)
                    {

                        existingItem.Quantity += quantity; // Nếu đã tồn tại, tăng số lượng lên
                                                           //cartExit.Quantity += quantity;
                                                           //HttpContext.Session.Set<List<ShoppingCartItem>>("Cart", cartItem);
                    }
                    else
                    {
                        // Nếu chưa tồn tại, thêm mới vào giỏ hàng
                        ShoppingCartItem newItem = new ShoppingCartItem
                        {
                            IdCartItem = GenerateNextCartItemId(), // Tạo một id_cart_item duy nhất
                            IdCart = idCartNew,
                            IdProItem = idProductItem,
                            Quantity = quantity,
                            Price = price,
                            IdPro = idProduct,
                        };

                        cart.ShoppingCartItems.Add(newItem);
                        //cartItem.Add(newItem);
                        //HttpContext.Session.Set<List<ShoppingCartItem>>("Cart", cartItem);

                    }

                    _context.SaveChanges(); // Lưu thay đổi vào cơ sở dữ liệu

                    _Inotiyfyservice.Success("Add product successfully", 2);
                    return Json(new { success = true });
                    // Trả về kết quả thành công
                }

                return Json(new { success = false });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, error = ex.Message }); // Trả về thông báo lỗi
            }
        }



        [HttpGet]
        public IActionResult Remove(string id)
        {

            try
            {

                //Thêm sp vào giỏ hàng
                var item = _context.ShoppingCartItems.SingleOrDefault(p => p.IdCartItem == id);
                //Đã có cập nhật số lượng
                if (item != null)
                {
                    _context.ShoppingCartItems.Remove(item);
                    _context.SaveChanges();
                }
                else
                {
                    // Nếu không tìm thấy mục trong giỏ hàng, bạn có thể thực hiện xử lý tùy ý, ví dụ như throw exception hoặc hiển thị thông báo lỗi
                    throw new Exception("Không tìm thấy mục trong giỏ hàng để xóa.");
                }


                //Lưu lại session

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }
        }


        [Route("cart", Name = "Cart")]
        public IActionResult Index()
        {
            List<ShoppingCartItem> shopCartItems = null;

            string userId = _userManager.GetUserId(User);
            if (userId != null)
            {
                ShoppingCart cart = _context.ShoppingCarts.SingleOrDefault(c => c.IdAcc == userId);
                if (cart != null)
                {
                    shopCartItems = _context.ShoppingCartItems.Include(p => p.IdProItemNavigation).Include(e => e.IdProNavigation.ImgPros).Include(pr => pr.IdProNavigation.ProductItems)
               .Where(item => item.IdCart == cart.IdCart).ToList();


                    return View(shopCartItems);
                }

                return RedirectToAction("Index", "Home");

            }
            else
            {
                return RedirectToAction("Index", "Home");
            }


        }
        [HttpPost]
        public async Task<IActionResult> UpdateQuantity(int quantity, string iditem)
        {

            var userid = _userManager.GetUserId(User);
            var cartitem = new ShoppingCartItem();
            var cart = await _context.ShoppingCarts.FirstOrDefaultAsync(u => u.IdAcc == userid);
            if (cart != null)
            {
                cartitem = await _context.ShoppingCartItems.FirstOrDefaultAsync(u => u.IdCart == cart.IdCart && u.IdProItem == iditem);
                if (cartitem != null)
                {
                    if (quantity <= 0 || quantity == null)
                    {
                        cartitem.Quantity = 1;
                    }
                    else
                    {
                        cartitem.Quantity = quantity;
                    }

                    _context.ShoppingCartItems.Update(cartitem);
                    await _context.SaveChangesAsync();

                }
            }
            List<ShoppingCartItem> shopCartItems = null;

            string userId = _userManager.GetUserId(User);
            if (userId != null)
            {
                ShoppingCart carts = _context.ShoppingCarts.SingleOrDefault(c => c.IdAcc == userId);
                if (cart != null)
                {
                    shopCartItems = _context.ShoppingCartItems.Include(p => p.IdProItemNavigation).Include(p => p.IdProNavigation).ThenInclude(pr => pr.ProductItems)
               .Where(item => item.IdCart == cart.IdCart).ToList();



                }



            }
            return PartialView("_ShoppingCartPartial", shopCartItems);
        }
        [HttpGet]
        public async Task<IActionResult> UpdateKind(string cartItemId, string proitemId)
        {
            var update = new UpdateCart();
            if (cartItemId == null)
            {
                return NotFound();
            }

            var product = await _context.Products
                .Include(c => c.ProductItems)
                .FirstOrDefaultAsync(p => p.IdPro == proitemId);

            var cartitem = await _context.ShoppingCartItems
                .FirstOrDefaultAsync(c => c.IdCartItem == cartItemId);

            if (product != null)
            {
                update = new UpdateCart
                {
                    proitem = product.ProductItems,
                    ShoppingCartItem = cartitem,
                };
            }



            return PartialView("_UpdateKind", update);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateKind(string idcartitem, string newitem, int newquantity)
        {
            if (idcartitem == null)
            {
                return NotFound();
            }
            var cartItem = _context.ShoppingCartItems.FirstOrDefault(c => c.IdCartItem == idcartitem);
            if (cartItem != null)
            {
                var productItem = _context.ProductItems.FirstOrDefault(p => p.IdProItem == newitem);
                if (productItem != null)
                {
                    if (newquantity <= 0)
                    {
                        cartItem.Quantity = 1;
                    }
                    else
                    {
                        cartItem.Quantity = newquantity;
                    }
                    cartItem.IdProItem = newitem;
                    cartItem.Price = productItem.ProPrice;
                    _context.ShoppingCartItems.Update(cartItem);
                    await _context.SaveChangesAsync();



                }
            }

            return RedirectToAction(nameof(Index));
        }


    }
}
