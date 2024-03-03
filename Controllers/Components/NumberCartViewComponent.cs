using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using App.Extension;
using App.ModelViews;
using Microsoft.AspNetCore.Mvc;

namespace App.Controllers.Components
{
    public class NumberCartViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke()
        {   
            var cart = HttpContext.Session.Get<List<CartCartItem>>("Cart");
            return View(cart);
        }
    }
}