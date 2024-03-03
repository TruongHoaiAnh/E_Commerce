using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using App.Areas.Admin.ViewModels;
using App.Model;

namespace App.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AccountsBuyerController : Controller
    {
        private readonly ECommerceContext _context;

        public AccountsBuyerController(ECommerceContext context)
        {
            _context = context;
        }

        // GET: Admin/Accounts
        public async Task<IActionResult> Index()
        {
            return View(await _context.Users.ToListAsync());
        }

        // GET: Admin/Accounts/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var account = await _context.Users
                .FirstOrDefaultAsync(m => m.Id == id);
            if (account == null)
            {
                return NotFound();
            }

            return View(account);
        }

        // GET: Admin/Accounts/Create
        public IActionResult Create()
        {
            return View();
        }
        

        // POST: Admin/Accounts/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(User account)
        {
            if (ModelState.IsValid)
            {
                _context.Add(account);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(account);
        }

        // GET: Admin/Accounts/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var account = await _context.Users.FindAsync(id);

            if (account == null)
            {
                return NotFound();
            }

            var viewModel = new EditAccountViewModel
            {
                IdAcc = account.Id,
                Username = account.UserName,
                Password = account.PasswordHash,
                Fullname = account.FullName,
                Email = account.Email,
                Phone = account.PhoneNumber,
                Gender = account.Gender,
                Birthday = account.BirthDate,

            };

            return View(viewModel);
        }

        // POST: Admin/Accounts/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(EditAccountViewModel viewModel)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var existingAccount = await _context.Users.FindAsync(viewModel.IdAcc);

                    if (existingAccount == null)
                    {
                        return NotFound();
                    }

                    existingAccount.UserName = viewModel.Username;
                    existingAccount.PasswordHash = viewModel.Password;
                    existingAccount.FullName = viewModel.Fullname;
                    existingAccount.Email = viewModel.Email;
                    existingAccount.PhoneNumber = viewModel.Phone;
                    existingAccount.Gender = viewModel.Gender;
                    existingAccount.BirthDate = viewModel.Birthday;

                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AccountExists(viewModel.IdAcc))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
            }

            return View(viewModel);
        }

        // GET: Admin/Accounts/Delete/5
        public async Task<IActionResult> Disable(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var account = await _context.Users
                .FirstOrDefaultAsync(m => m.Id == id);
            if (account == null)
            {
                return NotFound();
            }

            return View(account);
        }

        // POST: Admin/Accounts/Delete/5
        [HttpPost, ActionName("Disable")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Disablefirmed(string id)
        {
            var account = await _context.Users.FindAsync(id);
            if (account == null)
            {
                return NotFound();
            }
            account.Status = 0;
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));

        }
        [HttpPost, ActionName("Activation")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Activationfirmed(string id)
        {
            var account = await _context.Users.FindAsync(id);
            if (account == null)
            {
                return NotFound();
            }
            account.Status = 1;
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));

        }

        private bool AccountExists(string id)
        {
            return _context.Users.Any(e => e.Id == id);
        }

        [HttpGet]
        public IActionResult Search(string name)
        {
            var buyer = from s in _context.Users select s;
            if (!String.IsNullOrEmpty(name))
            {
                buyer = buyer.Where(x => x.FullName.Contains(name));
            }
            return View("Index", buyer);
        }
    }
}
