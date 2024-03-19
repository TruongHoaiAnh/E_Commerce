using App.Data;
using App.Model;
using App.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace App.Areas.Seller.Controllers
{
	[Area("Seller")]
	[Authorize(Roles = RoleName.Seller)]
	public class RevenuesController : Controller
	{
		private readonly E_CommerceContext _context;
		private readonly UserManager<AppUser> _userManager;
		private readonly SignInManager<AppUser> _signInManager;

		public RevenuesController(E_CommerceContext context, UserManager<AppUser> userManager, SignInManager<AppUser> signInManager)
		{
			_context = context;
			_userManager = userManager;
			_signInManager = signInManager;
		}

		//Day
		[HttpGet("/seller/revanues/")]
		public async Task<IActionResult> Index()
		{
			ViewBag.method = 2;
			var valueIdAcc = _userManager.GetUserId(User);
			DateTime date = DateTime.UtcNow;
			var orderDetails = _context.Orders
											.Include(o => o.OrderDetails)
											.ThenInclude(od => od.IdProItemNavigation)
											.ThenInclude(pi => pi.IdProNavigation)
											.Where(o => o.OrderDate.Date == date
											&& o.OrderDetails.Any(od => od.IdProItemNavigation.IdProNavigation.IdAcc == valueIdAcc))
											.GroupBy(o => new { o.OrderDate.Hour, o.OrderDate.Day })
											.Select(group => new
											{
												Date = group.Key,
												TotalAmount = group.Sum(o => o.OrderTotal)
											})
											.ToList();
			var viewModelList = new List<YourTime>();
			foreach (var item in orderDetails)
			{
				Console.WriteLine("lable" + item.Date + "h");
				Console.WriteLine("value" + item.TotalAmount);
				viewModelList.Add(new YourTime
				{

					lable = item.Date + "h",
					value = item.TotalAmount
				});
			}
			var selectList = new SelectList(viewModelList.Select(x => new SelectListItem
			{
				Text = x.lable,
				Value = x.value.ToString() // Assuming value is numeric, convert to string
			}), "Value", "Text");

			ViewBag.viewModelList = selectList;
			Console.WriteLine("orderDetails" + orderDetails);
			return View();
		}
		[HttpPost("/seller/revanues/")]
		public async Task<IActionResult> Index(YourTime y, int method)
		{
			var valueIdAcc = _userManager.GetUserId(User);
			var viewModelList = new List<YourTime>();
			if (method == 1)
			{
				var orderDetails = _context.Orders
											.Include(o => o.OrderDetails)
											.ThenInclude(od => od.IdProItemNavigation)
											.ThenInclude(pi => pi.IdProNavigation)
											.Where(o => o.OrderDate.Date >= y.startDate && o.OrderDate.Date <= y.endDate
											&& o.OrderDetails.Any(od => od.IdProItemNavigation.IdProNavigation.IdAcc == valueIdAcc))
											.GroupBy(o => o.OrderDate.Date)
											.Select(group => new
											{
												Date = group.Key,
												TotalAmount = group.Sum(o => o.OrderTotal)
											})
											.ToList();
				foreach (var item in orderDetails)
				{
					viewModelList.Add(new YourTime
					{
						lable = item.Date + "",
						value = item.TotalAmount
					});
				}
				var selectList = new SelectList(viewModelList.Select(x => new SelectListItem
				{
					Text = x.lable,
					Value = x.value.ToString() // Assuming value is numeric, convert to string
				}), "Value", "Text");

				ViewBag.viewModelList = selectList;
			}
			else
			if (method == 3)
			{
				var orderDetails = _context.Orders
											.Include(o => o.OrderDetails)
											.ThenInclude(od => od.IdProItemNavigation)
											.ThenInclude(pi => pi.IdProNavigation)
											.Where(o => o.OrderDate.Month >= y.startDate.Month && o.OrderDate.Year <= y.startDate.Year
											&& o.OrderDetails.Any(od => od.IdProItemNavigation.IdProNavigation.IdAcc == valueIdAcc))
											.GroupBy(o => new { o.OrderDate.Month, o.OrderDate.Year })
											.Select(group => new
											{
												Date = group.Key,
												TotalAmount = group.Sum(o => o.OrderTotal)
											})
											.ToList();
				foreach (var item in orderDetails)
				{
					viewModelList.Add(new YourTime
					{
						lable = item.Date + "",
						value = item.TotalAmount
					});
				}
				var selectList = new SelectList(viewModelList.Select(x => new SelectListItem
				{
					Text = x.lable,
					Value = x.value.ToString() // Assuming value is numeric, convert to string
				}), "Value", "Text");

				ViewBag.viewModelList = selectList;
			}
			else
			if (method == 4)
			{
				var orderDetails = _context.Orders
											.Include(o => o.OrderDetails)
											.ThenInclude(od => od.IdProItemNavigation)
											.ThenInclude(pi => pi.IdProNavigation)
											.Where(o => o.OrderDate.Year <= y.startDate.Year
											&& o.OrderDetails.Any(od => od.IdProItemNavigation.IdProNavigation.IdAcc == valueIdAcc))
											.GroupBy(o => o.OrderDate.Year)
											.Select(group => new
											{
												Date = group.Key,
												TotalAmount = group.Sum(o => o.OrderTotal)
											})
											.ToList();
				foreach (var item in orderDetails)
				{
					viewModelList.Add(new YourTime
					{
						lable = item.Date + "",
						value = item.TotalAmount
					});
				}
				var selectList = new SelectList(viewModelList.Select(x => new SelectListItem
				{
					Text = x.lable,
					Value = x.value.ToString() // Assuming value is numeric, convert to string
				}), "Value", "Text");

				ViewBag.viewModelList = selectList;
			}
			else return RedirectToAction("Index");
			return View();
		}
	}
}
