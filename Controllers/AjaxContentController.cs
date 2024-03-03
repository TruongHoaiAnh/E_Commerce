using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace App.Controllers
{
    public class AjaxContentController : Controller
    {
       public IActionResult HeaderCart()
       {
           return ViewComponent("HeaderCart");
       }
       public IActionResult NumberCart()
       {
           return ViewComponent("NumberCart");
       }
       
    }
}