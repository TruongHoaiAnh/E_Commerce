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
        }

        public string IdProItem { get; set; }
        public string IdPro { get; set; }
        public int Quantity { get; set; }
        public string ProImg { get; set; }
        public double ProPrice { get; set; }
        public double? Discount { get; set; }
        public int? BestSeller { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public int? StatusProItem { get; set; }
        public string Kind { get; set; }

        public virtual Product IdProNavigation { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
