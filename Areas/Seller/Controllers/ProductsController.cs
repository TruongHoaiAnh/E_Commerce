using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using App.Model;
using Microsoft.CodeAnalysis;

namespace App.Areas.Seller.Controllers
{
	[Area("Seller")]
	[ValidateSeller]
	public class ProductsController : Controller
	{
		private readonly ECommerceContext _context;

		public ProductsController(ECommerceContext context)
		{
			_context = context;
		}

		// GET: Seller/Products
		public async Task<IActionResult> Index()
		{
			//var cookieIdAccValue = Request.Cookies["IdAcc"];

			var query = from product in _context.Products
						join category in _context.Categories on product.IdCate equals category.IdCate
						join productItems in _context.ProductItems on product.IdPro equals productItems.IdPro
						select new
						{
							Product = product,
							ProductItem = productItems,
							Category = category
						};


			var result = await query.ToListAsync();
			var viewModelList = new List<ProCateProItemViewModel>();
			foreach (var item in result)
			{
				viewModelList.Add(new ProCateProItemViewModel
				{
					products = item.Product,
					productItems = item.ProductItem,
					categories = item.Category,
				});
			}
			return View(viewModelList);
		}

		// GET: Seller/Products/Details
		public async Task<IActionResult> Details(string id)
		{
			if (id == null)
			{
				return NotFound();
			}

			var product = await _context.Products
				.Include(p => p.IdAccNavigation)
				.Include(p => p.IdCateNavigation)
				.FirstOrDefaultAsync(m => m.IdPro == id);
			if (product == null)
			{
				return NotFound();
			}

			return View(product);
		}
		//GET:when create new products then system will auto create IdPro
		public string GenerateNextProductId()
		{
			// Retrieve the maximum existing Id_pro
			string maxIdPro = _context.Products
				.Select(p => p.IdPro)
				.OrderByDescending(id => id)
				.FirstOrDefault();

			// Generate the next Id_pro
			int nextNumber = 1;
			if (!string.IsNullOrEmpty(maxIdPro))
			{
				string numericPart = maxIdPro.Substring(2); // Extract numeric part
				if (int.TryParse(numericPart, out int numericValue))
				{
					nextNumber = numericValue + 1;
				}
			}

			string nextIdPro = $"PR{nextNumber:D3}"; // Format the new Id_pro

			return nextIdPro;
		}

		// GET: Seller/Products/Create
		public IActionResult Create()
		{
			ViewData["IdCate"] = new SelectList(_context.Categories, "IdCate", "NameCate");
			return View();
		}

		// POST: Seller/Products/Create
		// To protect from overposting attacks, enable the specific properties you want to bind to.
		// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Create([Bind("Name,Description,IdCate")] Product product)
		{
			if (ModelState.IsValid)
			{
				product.IdPro = GenerateNextProductId();
				product.StatusPro = 1;
				product.IdAcc = HttpContext.Session.GetString("IdAcc");
				_context.Add(product);
				await _context.SaveChangesAsync();
				return RedirectToAction(nameof(Index));
			}
			ViewData["IdAcc"] = new SelectList(_context.Users, "IdAcc", "IdAcc", product.IdAcc);
			ViewData["IdCate"] = new SelectList(_context.Categories, "IdCate", "IdCate", product.IdCate);
			return View(product);
		}

		// GET: Seller/Products/Edit/5
		public async Task<IActionResult> Edit(string id)
		{
			if (id == null)
			{
				return NotFound();
			}

			var product = await _context.Products.FindAsync(id);
			if (product == null)
			{
				return NotFound();
			}
			ViewData["IdAcc"] = new SelectList(_context.Users, "IdAcc", "IdAcc", product.IdAcc);
			ViewData["IdCate"] = new SelectList(_context.Categories, "IdCate", "IdCate", product.IdCate);
			return View(product);
		}

		// POST: Seller/Products/Edit/5
		// To protect from overposting attacks, enable the specific properties you want to bind to.
		// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Edit(string id, [Bind("IdPro,Name,Description,IdCate,IdAcc,StatusPro")] Product product)
		{
			if (id != product.IdPro)
			{
				return NotFound();
			}

			if (ModelState.IsValid)
			{
				try
				{
					_context.Update(product);
					await _context.SaveChangesAsync();
				}
				catch (DbUpdateConcurrencyException)
				{
					if (!ProductExists(product.IdPro))
					{
						return NotFound();
					}
					else
					{
						throw;
					}
				}
				return RedirectToAction(nameof(Index));
			}
			ViewData["IdAcc"] = new SelectList(_context.Users, "IdAcc", "IdAcc", product.IdAcc);
			ViewData["IdCate"] = new SelectList(_context.Categories, "IdCate", "IdCate", product.IdCate);
			return View(product);
		}

		// GET: Seller/Products/Delete/5
		public async Task<IActionResult> Delete(string id)
		{
			if (id == null)
			{
				return NotFound();
			}

			var product = await _context.Products
				.Include(p => p.IdAccNavigation)
				.Include(p => p.IdCateNavigation)
				.FirstOrDefaultAsync(m => m.IdPro == id);
			if (product == null)
			{
				return NotFound();
			}

			return View(product);
		}

		// POST: Seller/Products/Delete/5
		[HttpPost, ActionName("Delete")]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> DeleteConfirmed(string id)
		{
			var product = await _context.Products.FindAsync(id);
			_context.Products.Remove(product);
			await _context.SaveChangesAsync();
			return RedirectToAction(nameof(Index));
		}

		private bool ProductExists(string id)
		{
			return _context.Products.Any(e => e.IdPro == id);
		}

	}
}
