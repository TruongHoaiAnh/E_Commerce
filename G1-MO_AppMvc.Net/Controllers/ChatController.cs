﻿using Microsoft.AspNetCore.Mvc;

namespace App.Controllers
{
    public class ChatController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
