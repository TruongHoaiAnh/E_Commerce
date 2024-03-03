using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using App.Extension;
using App.ModelViews;
using Microsoft.AspNetCore.Mvc;

namespace App.Components
{
    public class HeaderCartViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke()
        {   
            var cart = HttpContext.Session.Get<List<CartCartItem>>("Cart");
            return View(cart);
        }
    }
}