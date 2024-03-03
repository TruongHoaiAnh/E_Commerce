using App.Model;
using App.Model;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.CodeAnalysis.FlowAnalysis;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Controllers
{
    public class ProductController : Controller
    {

        private readonly ECommerceContext _context;

        public ProductController(ECommerceContext context)
        {
            _context = context;
        }

        [Route("Shop.html", Name = "ShopProduct")]
        public IActionResult Index(int? page)
        {
            try
            {
                
                var pageNumber = page == null || page <= 0 ? 1 : page.Value;
                var pageSize = 10;
                var lsProduct = _context.Products.AsNoTracking()
                    .Include(p => p.ProductItems)
                    .OrderByDescending(x => x.Name);
                PagedList<Product> models = new PagedList<Product>(lsProduct, pageNumber, pageSize);
                ViewBag.CurrentPage = pageNumber;

                
                var query = from p in _context.Products
                             join c in _context.Categories on p.IdCate equals c.IdCate
                             join pI in _context.ProductItems on p.IdPro equals pI.IdPro
                             select new
                             {
                                 Product = p,
                                 ProductItem = pI,
                                 Category = c
                             };
                //Lấy ra một object
                var result = query.FirstOrDefault(); // Get the first or default item
                if (result == null)
                {
                    return RedirectToAction("Index", "Home");
                }
                var product = new ProCateProItemViewModel
                {
                    products = result.Product,
                    productItems = result.ProductItem,
                    categories = result.Category
                };
                ViewBag.Product = product;


                return View(models);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }
        }

        //[Route("/{Name}.html", Name = "ListProduct")]
        public ActionResult List(string Name, int Page = 1)
        {
            try
            {
                var pageSize = 10;
                var danhmuc = _context.Categories.AsNoTracking().SingleOrDefault(x => x.NameCate == Name);
                var lsProduct = _context.Products.AsNoTracking()
                    .Where(x => x.IdCate == danhmuc.IdCate)
                    .OrderByDescending(x => x.Name);
                PagedList<Product> models = new PagedList<Product>(lsProduct, Page, pageSize);
                ViewBag.CurrentPage = Page;
                ViewBag.CurrentCate = danhmuc;

                return View(models);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }

        }


        // [Route("/{Alias}-{id}.html", Name = "ProductDetails")]
        [Route("/{Name}-{id}.html", Name = "ProductDetails")]

        public IActionResult Detail(string id)
        {
            try
            {
                var query1 = from p in _context.Products
                            join c in _context.Categories on p.IdCate equals c.IdCate
                            join pI in _context.ProductItems on p.IdPro equals pI.IdPro
                            where p.IdPro == id // Filter by product Id
                            select new
                            {
                                Product = p,
                                ProductItem = pI,
                                Category = c
                            };

                //Lấy ra một object
                var product = query1.FirstOrDefault(); // Get the first or default item
                if (product == null)
                {
                    return RedirectToAction("Index");
                }

                var viewModel = new ProCateProItemViewModel
                {
                    products = product.Product,
                    productItems = product.ProductItem,
                    categories = product.Category
                };



                //Lấy ds product cùng loại category 
                /*var query2 = from p in _context.Products
                             join c in _context.Categories on p.IdCate equals c.IdCate
                             join pI in _context.ProductItems on p.IdPro equals pI.IdPro
                             where(p.IdCate == product.Category.IdCate && p.IdPro != id && p.StatusPro == 1)
                             select new
                             {
                                 Product = p,
                                 ProductItem = pI,
                                 Category = c
                             };*/

                var query2 = from p in _context.Products
                            join c in _context.Categories on p.IdCate equals c.IdCate
                            join pI in _context.ProductItems on p.IdPro equals pI.IdPro
                            select new
                            {
                                Product = p,
                                ProductItem = pI,
                                Category = c
                            };

                //Lấy ra một list
                var lsproduct = query2
                    .Where(x => x.Category.IdCate == product.Category.IdCate && x.Product.IdPro != id && x.Product.StatusPro == 1)
                    //Nếu có ngày thì sắp xếp tăng dần theo ngày
                    .Take(4)
                    .ToList();
                var viewModelList = new List<ProCateProItemViewModel>();
                foreach (var item in lsproduct)
                {
                    viewModelList.Add(new ProCateProItemViewModel
                    {
                        products = item.Product,
                        productItems = item.ProductItem,
                        categories = item.Category,
                    });
                }


                ViewBag.lsProduct = viewModelList;




                return View(viewModel);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }
        }



    }
}
