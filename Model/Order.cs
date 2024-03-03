using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class Order
    {
        public Order()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public string IdOrder { get; set; }
        public string IdAcc { get; set; }
        public DateTime OrderDate { get; set; }
        public int PaymentMethodId { get; set; }
        public string IdAddress { get; set; }
        public double OrderTotal { get; set; }
        public int OrderStatus { get; set; }
        public int? OrderStart { get; set; }
        public int? OrderInProgress { get; set; }
        public int? OrderEnd { get; set; }

        public virtual User IdAccNavigation { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
