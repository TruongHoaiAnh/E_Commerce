using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class Voucher
    {
        public string VoucherId { get; set; }
        public string PromotionCode { get; set; }
        public string PromotionName { get; set; }
        public int DiscountType { get; set; }
        public double DiscountAmount { get; set; }
        public double? MaxiValue { get; set; }
        public double? MinValue { get; set; }
        public int Quantity { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int UsageStatus { get; set; }
        public bool DeleteStatus { get; set; }
    }
}
