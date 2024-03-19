using App.Data;
using App.Models;
using App.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Threading.Tasks;
using SixLabors.ImageSharp;
using static System.Net.Mime.MediaTypeNames;
using App.Model;



namespace App.Areas.Admin.Controllers
{
    [Authorize(Roles = RoleName.Administrator)]
    [Area("Admin")]
    [Route("/ManageBanner/[action]")]

    public class BannerController : Controller
    {
        private readonly AppDbContext _context;

        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;

        public BannerController(AppDbContext context, UserManager<AppUser> userManager, SignInManager<AppUser> signInManager)
        {
            _context = context;
            _userManager = userManager;
            _signInManager = signInManager;
        }

        [HttpGet]
        public async Task<IActionResult> IndexBanner()
        {
            var firstBanner = await _context.Banners.FirstOrDefaultAsync();
            return View(firstBanner);
        }
        private Task<AppUser> GetCurrentUserAsync()
        {
            return _userManager.GetUserAsync(HttpContext.User);
        }

        public class UploadFile
        {

            [DataType(DataType.Upload)]
            [FileExtensions(Extensions = "png,jpg,jpeg")]
            [Display(Name = "Chon file")]
            public IFormFile FileUp { get; set; }
            [Display(Name = "Nhập nội dung")]
            public string Text { get; set; }
        }

        [HttpGet]
        public IActionResult UploadImg()
        {
            return View(new UploadFile());
        }
        [HttpPost]
        public async Task<IActionResult> UploadImgAsync(UploadFile file)
        {
            var firstBanner = await _context.Banners.FirstOrDefaultAsync();
            if (!ModelState.IsValid)
            {
                if (file.FileUp == null)
                {
                    firstBanner.Text = file.Text;
                    _context.Update(firstBanner);
                    _context.SaveChanges();

                }
                else
                {
                    var file1 = Path.GetFileNameWithoutExtension(Path.GetRandomFileName())
               + Path.GetExtension(file.FileUp.FileName);

                    var file2 = Path.Combine("wwwroot", "assests", "img", "hero", file1);
                    using (var filename = new FileStream(file2, FileMode.Create))
                    {
                        await file.FileUp.CopyToAsync(filename);
                    }
                    firstBanner.Link = file1;
                    firstBanner.Text = file.Text;
                    _context.Update(firstBanner);
                    _context.SaveChanges();
                }

            }

            return RedirectToAction("IndexBanner");
        }

        private bool CheckImageDimensions(IFormFile file, int width, int height)
        {
            using (var image = SixLabors.ImageSharp.Image.Load(file.OpenReadStream()))
            {
                return image.Width == width && image.Height == height;
            }
        }
    }
}
