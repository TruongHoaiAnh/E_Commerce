using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class ShoppingCartItem
    {
        public string IdCartItem { get; set; }
        public string IdCart { get; set; }
        public string IdProItem { get; set; }
        public int Quantity { get; set; }
        public double? Price { get; set; }

        public virtual ShoppingCart IdCartNavigation { get; set; }
    }
}
