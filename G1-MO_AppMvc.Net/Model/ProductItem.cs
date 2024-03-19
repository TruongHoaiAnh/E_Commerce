using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{

    public partial class ProductItem
    {
        public ProductItem()
        {
            OrderDetails = new HashSet<OrderDetail>();
            ShoppingCartItems = new HashSet<ShoppingCartItem>();
        }


		public string IdProItem { get; set; }
		public string IdPro { get; set; }
		public string Name { get; set; }
		public int Quantity { get; set; }
		public double ProPrice { get; set; }
		public double? Discount { get; set; }
		public int? StatusProItem { get; set; }

        public virtual Product IdProNavigation { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual ICollection<ShoppingCartItem> ShoppingCartItems { get; set; }
    }

}
