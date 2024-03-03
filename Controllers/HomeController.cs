using App.Data;
using App.Models;
using App.Model;
using App.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace App.Controllers
{
	public class HomeController : Controller
	{
		private string admin = GetMD5("0");
		private string seller = GetMD5("1");
		private string buyer = GetMD5("2");
		private readonly UserManager<AppUser> _userManager;
		private readonly RoleManager<IdentityRole> _roleManager;
		public readonly AppDbContext _dbContext;


		private readonly ILogger<HomeController> _logger;
		ECommerceContext objModel = new ECommerceContext();

		public HomeController(UserManager<AppUser> userManager, RoleManager<IdentityRole> roleManager, AppDbContext dbContext, ILogger<HomeController> logger)
		{
			_userManager = userManager;
			_roleManager = roleManager;
			_dbContext = dbContext;
			_logger = logger;
		}

		public async Task<IActionResult> SeedDataAsync()
		{
			var rolenames = typeof(RoleName).GetFields().ToList();
			foreach(var r in rolenames)
			{
				var rolename = (string)r.GetRawConstantValue();
				var rfound = await _roleManager.FindByNameAsync(rolename);
				if(rfound == null)
				{
					await _roleManager.CreateAsync(new IdentityRole(rolename));
				}
			}
			//admin , admin123, admin@example.com
			var useradmin = await _userManager.FindByEmailAsync("admin");
			if(useradmin == null)
			{
				useradmin = new AppUser()
				{
					UserName = "admin",
					Email = "admin@example.com",
					EmailConfirmed = true,
				};
				await _userManager.CreateAsync(useradmin, "admin123");
				await _userManager.AddToRoleAsync(useradmin, RoleName.Administrator);
			}
			
			return View("Index");
		}


		public IActionResult Index()
		{

			//check cookies, lấy ra cookies để kiểm tra
			var cookieRoleValue = Request.Cookies["role"];


			//cookie for role: 1 is seller, 0 is admin, 2 is buyer
			if (cookieRoleValue != null)
			{
				if (cookieRoleValue.Equals(admin))
				{
					return RedirectToAction("Index", new { area = "Admin" });
				}
				else
				{
					if (cookieRoleValue.Equals(seller))
					{
						return RedirectToAction("Index", new { area = "Seller" });
					}
				}
			}

			return View();
		}


		public IActionResult Privacy()
		{
			return View();
		}

		[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
		public IActionResult Error()
		{
			return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
		}
		public ActionResult Login()
		{
			return View("Login");
		}

		[HttpPost]
		[ValidateAntiForgeryToken]
		public ActionResult Login(string username, string password)
		{
			if (ModelState.IsValid)
			{


				string key = "username";
				var f_password = GetMD5(password);

				var data = objModel.Users.Where(s => s.UserName.Equals(username) && s.PasswordHash.Equals(f_password)).ToList();
				Console.WriteLine(data);
				if (data.Count() > 0)
				{

					//add cookie
					string value = data.FirstOrDefault().UserName;
					CookieOptions options = new CookieOptions()
					{
						//khai báo an toàn, đòi hỏi web phải chạy trên https
						Secure = true,

						//Chỉ đặt cookie thành HTTP
						HttpOnly = true,

						Expires = DateTime.Now.AddDays(5)//set thời gian
					};

					//add cookies lên
					Response.Cookies.Append(key, value, options);



					//add session
					HttpContext.Session.SetString("Fullname", data.FirstOrDefault().FullName);
					HttpContext.Session.SetString("Username", data.FirstOrDefault().UserName);
					HttpContext.Session.SetString("IdAcc", data.FirstOrDefault().Id);
					HttpContext.Session.SetString("Email", data.FirstOrDefault().Email);


					//set cookies id để cấp quyền đúng account cho lần đăng nhập tiếp
					Response.Cookies.Append("idAcc", data.FirstOrDefault().Id, options);



					//add cookie for role: 1 is seller, 0 is admin, 2 is buyer
					if (HttpContext.Session.GetString("IsSeller") == "1")
					{
						//if (cookieRoleValue == null)
						//{
						Response.Cookies.Append("role", seller, options);
						//}
						return RedirectToAction("Index", "Products", new { area = "Seller" });
					}
					else
					{
						if (HttpContext.Session.GetString("IsAdmin") == "1")
						{
							//if (cookieRoleValue == null)
							//{
							Response.Cookies.Append("role", admin, options);
							//}
							return RedirectToAction("Index", new { area = "Admin" });
						}
						else
						{

							//if (cookieRoleValue == null)
							//{
							Response.Cookies.Append("role", buyer, options);
							//}

							return RedirectToAction("Index");
						}

					}
				}
				else
				{
					ViewBag.error = "Login failed";
					return RedirectToAction("Login");
				}
			}
			return View();
		}

		//create a string MD5
		public static string GetMD5(string str)
		{
			MD5 md5 = new MD5CryptoServiceProvider();
			byte[] fromData = Encoding.UTF8.GetBytes(str);
			byte[] targetData = md5.ComputeHash(fromData);
			string byte2String = null;

			for (int i = 0; i < targetData.Length; i++)
			{
				byte2String += targetData[i].ToString("x2");

			}
			return byte2String;
		}

	}
}
