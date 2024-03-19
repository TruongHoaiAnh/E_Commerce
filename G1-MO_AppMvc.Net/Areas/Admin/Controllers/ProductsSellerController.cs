using App.Areas.Identity.Controllers;
using App.Data;
using App.Model;
using App.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System.Linq;
using X.PagedList;

namespace App.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = RoleName.Administrator)]
    [Route("/ManageProduct/[action]")]
    public class ProductsSellerController : Controller
    {
        private readonly E_CommerceContext _context;
        private readonly UserManager<AppUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly AppDbContext _contextapp;
        private readonly ILogger<RoleController> _logger;

        public ProductsSellerController(E_CommerceContext context, UserManager<AppUser> userManager, RoleManager<IdentityRole> roleManager, AppDbContext contextapp, ILogger<RoleController> logger)
        {
            _context = context;
            _userManager = userManager;
            _roleManager = roleManager;
            _contextapp = contextapp;
            _logger = logger;
        }
        [HttpGet("{id}")]
        public IActionResult IndexProSeller(string id, int? page)
        {
            var pageNumber = page == null || page <= 0 ? 1 : page.Value;
            var pageSize = 5;
            var lsProduct = _context.Products.AsNoTracking()
                    .Include(p => p.ProductItems).Include(i => i.ImgPros)
                    .OrderByDescending(x => x.StatusPro).Where(u => u.IdAcc == id);
            IPagedList<Product> models = new PagedList<Product>((IQueryable<Product>)lsProduct, pageNumber, pageSize);
            ViewBag.CurrentPage = pageNumber;
            ViewBag.url = id;

            return View(models);
        }

        [HttpGet("{id}")]
        public IActionResult Delete(string id, string userid)
        {
            
            var pro = _context.Products.Find(id);
            if (pro != null)
            {
                pro.StatusPro = 0;
                _context.Update(pro);
                _context.SaveChanges();
            }
            return RedirectToAction("IndexProSeller", new {id = userid });
        }
    }
}
