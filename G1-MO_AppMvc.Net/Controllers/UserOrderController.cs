using App.Model;
using App.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace App.Controllers
{
    [Authorize]
    public class UserOrderController : Controller
    {
        private readonly E_CommerceContext _context;
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;

        public UserOrderController(E_CommerceContext context, UserManager<AppUser> userManager, SignInManager<AppUser> signInManager)
        {
            _context = context;
            _userManager = userManager;
            _signInManager = signInManager;
        }

        //[HttpGet("/user/order/")]
        public async Task<IActionResult> Index()
        {
            string userId = _userManager.GetUserId(User);
            List<Order> orders = _context.Orders.Where(x => x.IdAcc == userId).ToList();
            return View(orders);
        }
        //public ActionResult CheckoutOrder()
        //{

        //	string userId = _userManager.GetUserId(User);
        //	List<Order> orders = _context.Orders.Where(x => x.IdAcc == userId).ToList();
        //	return View(orders);
        //}

        public ActionResult Received(string ID)
        {
            Order order = _context.Orders.Find(ID);
            order.OrderInProgress = 4;
            _context.SaveChanges();

            // Cập nhật sản phẩm
            List<OrderDetail> orderDetails = _context.OrderDetails.Where(x => x.IdOrder == ID).ToList();
            foreach (var item in orderDetails)
            {
                ProductItem productItem = _context.ProductItems
    .Include(pi => pi.IdProNavigation) // Include thông tin về sản phẩm liên kết với mục sản phẩm
    .FirstOrDefault(pi => pi.IdProItem == item.IdProItem);

                productItem.Quantity -= item.Quantity;
                var total = item.Quantity * item.Price;
                var user = productItem.IdProNavigation.IdAcc;
                var wallet = _context.Wallets.SingleOrDefault(e => e.IdAcc == user);
                wallet.Balance += total;
                _context.SaveChanges();
            }




            return RedirectToAction("Index", "UserOrder");
        }

        //[HttpGet("/userOrderDetail/")]
        public async Task<IActionResult> OrderDetails(string id)
        {
            var query = from order_detail in _context.OrderDetails
                        join product_item in _context.ProductItems
                        on order_detail.IdProItem equals product_item.IdProItem
                        where order_detail.IdOrder == id
                        select new
                        {
                            OrderDetail = order_detail,
                            ProductItem = product_item
                        };

            var result = await query.ToListAsync();
            var viewModelList = new List<ItemDetailViewModel>();

            foreach (var item in result)
            {
                viewModelList.Add(new ItemDetailViewModel
                {
                    orderDetail = item.OrderDetail,
                    productItem = item.ProductItem
                });
            }
            ViewBag.IdOrder = id;
            Order order = _context.Orders.Where(o => o.IdOrder == id).FirstOrDefault();
            ViewBag.OrderInProgress = order.OrderInProgress;

            return View(viewModelList);
        }

        [HttpGet("/User/CancelOrder")]
        public IActionResult CancelOrder(string ID)
        {

            Order order = _context.Orders.Find(ID);
            order.OrderStatus = 0;
            _context.SaveChanges();
          




            var user = order.IdAcc;
            var wallet = _context.Wallets.SingleOrDefault(e => e.IdAcc == user);
            if (order.OrderTotalDiscount != null && order.OrderTotalDiscount > 0)
            {
                wallet.Balance += (double)order.OrderTotalDiscount;
                _context.SaveChanges();
            }
            else
            {
                wallet.Balance += order.OrderTotal;
                _context.SaveChanges();
            }

           

            return RedirectToAction("Index", "UserOrder");
        }

        [HttpGet("/User/ListCancelOrder")]
        public IActionResult userListOrderCanceled()
        {
            string userId = _userManager.GetUserId(User);
            var order = _context.Orders.Where(o => o.OrderStatus == 0 && o.IdAcc == userId);
            return View(order);
        }

    }
}
