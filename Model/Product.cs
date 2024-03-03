using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class Product
    {
        public Product()
        {
            ProductItems = new HashSet<ProductItem>();
            Reviews = new HashSet<Review>();
            Wishlists = new HashSet<Wishlist>();
        }

        public string IdPro { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string IdCate { get; set; }
        public string IdAcc { get; set; }
        public int StatusPro { get; set; }

        public virtual User IdAccNavigation { get; set; }
        public virtual Category IdCateNavigation { get; set; }
        public virtual ICollection<ProductItem> ProductItems { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
        public virtual ICollection<Wishlist> Wishlists { get; set; }
    }
}
