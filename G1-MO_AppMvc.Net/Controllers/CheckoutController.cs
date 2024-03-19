using App.Extension;
using App.Model;
using App.Models;
using AspNetCoreHero.ToastNotification.Abstractions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace App.Controllers
{
    [RedirectAdmin]
    [Authorize]
    public class CheckoutController : Controller
    {
        private readonly E_CommerceContext _context;
        private readonly UserManager<AppUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly AppDbContext _contextapp;

        public CheckoutController(E_CommerceContext context, UserManager<AppUser> userManager, RoleManager<IdentityRole> roleManager, AppDbContext contextapp, INotyfService inotiyfyservice)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
            _contextapp = contextapp;
            _Inotiyfyservice = inotiyfyservice;
        }

        public INotyfService _Inotiyfyservice { get; }



        public async Task<IActionResult> Index(string voucherCode)
        {
            double value = 0;
            var voucher = _context.Vouchers.Where(v => v.PromotionCode == voucherCode).FirstOrDefault();
            if (voucher != null)
            {
                value = voucher.DiscountAmount;
            }
            else
            {
                value = 0;

            }
            HttpContext.Session.SetString("Discount", $"{value}");
            ViewBag.DiscountVoucher = value;



            var user = await _userManager.GetUserAsync(User);
            List<ShoppingCartItem> shopCartItems = null;

            string userId = _userManager.GetUserId(User);
            if (userId != null)
            {
                ShoppingCart cart = await _context.ShoppingCarts.SingleOrDefaultAsync(c => c.IdAcc == userId);
                shopCartItems = _context.ShoppingCartItems.Include(p => p.IdProItemNavigation).Include(p => p.IdProNavigation)
                .Where(item => item.IdCart == cart.IdCart).ToList();


                ViewData["Cart"] = shopCartItems;

                return View(user);

            }
            return RedirectToAction("Index", "Home");
        }
        public string GenerateNextOrderId()
        {
            // Retrieve the maximum existing Id_pro
            string maxIdAcc = _context.Orders
                .Select(p => p.IdOrder)
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

            string nextIdAcc = $"OR{nextNumber:D3}"; // Format the new Id_acc

            return nextIdAcc;
        }
        public string GenerateNextOrderDetailId()
        {
            // Retrieve the maximum existing Id_pro
            string maxIdAcc = _context.OrderDetails
                .Select(p => p.IdOrderDetail).OrderByDescending(id => id)
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

            string nextIdAcc = $"OD{nextNumber:D3}"; // Format the new Id_acc

            return nextIdAcc;
        }


        [HttpPost]
        public async Task<IActionResult> CheckoutShipCod(AppUser user, int methodPayment)
        {
            if (user.FullName != null && user.PhoneNumber != null && user.HomeAdress != null && user.Email != null)
            {
                List<ShoppingCartItem> shopCartItems = null;
                Order order = null;
                OrderDetail orderDetail = null;
                var userId = _userManager.GetUserId(User);


                ShoppingCart cart = await _context.ShoppingCarts.SingleOrDefaultAsync(c => c.IdAcc == userId);
                shopCartItems = _context.ShoppingCartItems.Include(p => p.IdProItemNavigation).Include(p => p.IdProNavigation)
                .Where(item => item.IdCart == cart.IdCart).ToList();


                var orderId = GenerateNextOrderId();
                double orderTotal = 0;

                string discount = HttpContext.Session.GetString("Discount");
                double d = 0;

                if (!string.IsNullOrEmpty(discount))
                {
                    if (!double.TryParse(discount, out d))
                    {
                    }
                }

                foreach (var item in shopCartItems)
                {
                    orderTotal += item.Quantity * (double)item.Price;
                }
                double orderTotalAfterDiscount = 0;

                if (d < 50)
                {
                    orderTotalAfterDiscount = orderTotal - (orderTotal * d) / 100;
                }
                else
                {
                    orderTotalAfterDiscount = orderTotal - d;
                }



                order = new Order
                {
                    OrderStatus = 1,
                    OrderDate = DateTime.Now,
                    OrderInProgress = 1,
                    PaymentMethodId = methodPayment,
                    IdAcc = userId,
                    Address = user.HomeAdress,
                    IdOrder = orderId,
                    OrderTotal = orderTotal,
                    OrderTotalDiscount = orderTotalAfterDiscount,
                    Email = user.Email,
                    Fullname = user.FullName,
                    Phone = user.PhoneNumber,

                };

                _context.Orders.Add(order);
                await _context.SaveChangesAsync();

                foreach (var item in shopCartItems)
                {
                    orderDetail = new OrderDetail
                    {

                        IdOrder = orderId,
                        IdOrderDetail = GenerateNextOrderDetailId(),
                        IdProItem = item.IdProItem,
                        Quantity = item.Quantity,
                        Price = (double)item.Price,
                        OrderTotal = item.Quantity * (double)item.Price,
                    };


                    _context.OrderDetails.Add(orderDetail);
                    await _context.SaveChangesAsync();

                }
                foreach (var item in shopCartItems)
                {
                    _context.ShoppingCartItems.Remove(item);
                }
                _context.ShoppingCarts.Remove(cart);


                await _context.SaveChangesAsync();
                if (methodPayment == 1)
                    return RedirectToAction("Index", "Home");
                else
                    return RedirectToAction("CheckOut", "Payment", order);
            }
            else
            {

                _Inotiyfyservice.Error("Please fill in all information!", 5);
                return RedirectToAction("Index");


            }
        }
        [HttpPost]
        public async Task<IActionResult> CheckoutVnpay(AppUser user)
        {
            if (ModelState.IsValid)
            {
                List<ShoppingCartItem> shopCartItems = null;
                Order order = null;
                OrderDetail orderDetail = null;
                var userId = _userManager.GetUserId(User);


                ShoppingCart cart = await _context.ShoppingCarts.SingleOrDefaultAsync(c => c.IdAcc == userId);
                shopCartItems = _context.ShoppingCartItems.Include(p => p.IdProItemNavigation).Include(p => p.IdProNavigation)
                 .Where(item => item.IdCart == cart.IdCart).ToList();


                var orderId = GenerateNextOrderId();
                double orderTotal = 0;
                foreach (var item in shopCartItems)
                {
                    orderTotal += item.Quantity * (double)item.Price;
                }

                string discount = HttpContext.Session.GetString("Discount");
                double d = 0;

                if (!string.IsNullOrEmpty(discount))
                {
                    if (!double.TryParse(discount, out d))
                    {
                    }
                }

                foreach (var item in shopCartItems)
                {
                    orderTotal += item.Quantity * (double)item.Price;
                }
                double orderTotalAfterDiscount = 0;

                if (d < 50)
                {
                    orderTotalAfterDiscount = orderTotal - (orderTotal * d) / 100;
                }
                else
                {
                    orderTotalAfterDiscount = orderTotal - d;
                }


                order = new Order
                {
                    OrderStatus = 1,
                    OrderDate = DateTime.Now,
                    OrderInProgress = 1,
                    PaymentMethodId = 2,
                    IdAcc = userId,
                    Address = user.HomeAdress,
                    IdOrder = orderId,
                    OrderTotal = orderTotal
                };

                _context.Orders.Add(order);
                await _context.SaveChangesAsync();

                foreach (var item in shopCartItems)
                {
                    orderDetail = new OrderDetail
                    {

                        IdOrder = orderId,
                        IdOrderDetail = GenerateNextOrderDetailId(),
                        IdProItem = item.IdProItem,
                        Quantity = item.Quantity,
                        Price = (double)item.Price,
                        OrderTotal = item.Quantity * (double)item.Price,
                    };


                    _context.OrderDetails.Add(orderDetail);
                    await _context.SaveChangesAsync();

                }
                foreach (var item in shopCartItems)
                {
                    _context.ShoppingCartItems.Remove(item);
                }
                _context.ShoppingCarts.Remove(cart);


                await _context.SaveChangesAsync();
                return RedirectToAction("CheckOut", "Payment", order);
            }


            return View(user);
        }
    }
}