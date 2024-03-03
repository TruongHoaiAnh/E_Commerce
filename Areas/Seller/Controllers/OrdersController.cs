using Microsoft.AspNetCore.Mvc;

using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using App.Model;

namespace App.Areas.Seller.Controllers
{
    [Area("Seller")]
    [ValidateSeller]
    public class OrdersController : Controller
    {
        private readonly ECommerceContext _context;

		public OrdersController(ECommerceContext context)
		{
			_context = context;
		}
        public async Task<IActionResult> Index()
        {
            var data = await _context.Orders.ToListAsync();
            return View(data);
        }
        public IActionResult Cancel()
        {
            return View();
        }
    }
}
