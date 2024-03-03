using System;
using System.Collections.Generic;

#nullable disable

namespace App.Model
{
    public partial class User
    {
        public User()
        {
            Orders = new HashSet<Order>();
            Products = new HashSet<Product>();
            Reviews = new HashSet<Review>();
            RoomChats = new HashSet<RoomChat>();
            ShoppingCarts = new HashSet<ShoppingCart>();
            UserClaims = new HashSet<UserClaim>();
            UserLogins = new HashSet<UserLogin>();
            UserRoles = new HashSet<UserRole>();
            UserTokens = new HashSet<UserToken>();
        }

        public string Id { get; set; }
        public string HomeAdress { get; set; }
        public DateTime? BirthDate { get; set; }
        public int Gender { get; set; }
        public DateTime? DateCreate { get; set; }
        public DateTime? LastLogin { get; set; }
        public DateTime? BlockDate { get; set; }
        public int Status { get; set; }
        public string FullName { get; set; }
        public string UserName { get; set; }
        public string NormalizedUserName { get; set; }
        public string Email { get; set; }
        public string NormalizedEmail { get; set; }
        public bool EmailConfirmed { get; set; }
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
        public string ConcurrencyStamp { get; set; }
        public string PhoneNumber { get; set; }
        public bool PhoneNumberConfirmed { get; set; }
        public bool TwoFactorEnabled { get; set; }
        public DateTimeOffset? LockoutEnd { get; set; }
        public bool LockoutEnabled { get; set; }
        public int AccessFailedCount { get; set; }

        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Product> Products { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
        public virtual ICollection<RoomChat> RoomChats { get; set; }
        public virtual ICollection<ShoppingCart> ShoppingCarts { get; set; }
        public virtual ICollection<UserClaim> UserClaims { get; set; }
        public virtual ICollection<UserLogin> UserLogins { get; set; }
        public virtual ICollection<UserRole> UserRoles { get; set; }
        public virtual ICollection<UserToken> UserTokens { get; set; }
    }
}
