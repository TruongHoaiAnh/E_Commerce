using App.Data;
using App.Model;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace App.Areas.Seller.Controllers
{
	[Area("Seller")]
	[Authorize(Roles = RoleName.Seller)]

    public class HomeController : Controller
	{
		private readonly ECommerceContext _context;
		public HomeController(ECommerceContext context)
		{
			_context = context;
		}
		[HttpGet("/seller/")]
		public IActionResult Index()
		{
				return View();
			}
		}
	}
