using System;
using System.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace App.Model
{
    public partial class ECommerceContext : DbContext
    {
        public ECommerceContext()
        {
        }

        public ECommerceContext(DbContextOptions<ECommerceContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Category> Categories { get; set; }
        public virtual DbSet<Contact> Contacts { get; set; }
        public virtual DbSet<Message> Messages { get; set; }
        public virtual DbSet<Order> Orders { get; set; }
        public virtual DbSet<OrderDetail> OrderDetails { get; set; }
        public virtual DbSet<Product> Products { get; set; }
        public virtual DbSet<ProductItem> ProductItems { get; set; }
        public virtual DbSet<Review> Reviews { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<RoleClaim> RoleClaims { get; set; }
        public virtual DbSet<RoomChat> RoomChats { get; set; }
        public virtual DbSet<ShoppingCart> ShoppingCarts { get; set; }
        public virtual DbSet<ShoppingCartItem> ShoppingCartItems { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserClaim> UserClaims { get; set; }
        public virtual DbSet<UserLogin> UserLogins { get; set; }
        public virtual DbSet<UserRole> UserRoles { get; set; }
        public virtual DbSet<UserToken> UserTokens { get; set; }
        public virtual DbSet<Voucher> Vouchers { get; set; }
        public virtual DbSet<Wishlist> Wishlists { get; set; }
        public virtual DbSet<GetAccountMonthAndYear> GetAccountMonthAndYears { get; set; }
        public IQueryable<GetAccountMonthAndYear> CallGetAccountBuyer(int year)
        {
            var parameters = new SqlParameter("@Year", year);
            return this.GetAccountMonthAndYears.FromSqlRaw("EXECUTE dbo.GetAccountBuyerCountByYear @Year", parameters);
        }
        public IQueryable<GetAccountMonthAndYear> CallGetAccountSeller(int year)
        {
            var parameters = new SqlParameter("@Year", year);
            return GetAccountMonthAndYears.FromSqlRaw("EXECUTE dbo.GetAccountSellerCountByYear @Year", parameters);
        }
        public IQueryable<GetAccountMonthAndYear> CallGetAccountDisable(int year)
        {
            var parameters = new SqlParameter("@Year", year);
            return GetAccountMonthAndYears.FromSqlRaw("EXECUTE dbo.GetAccountDisableByYear @Year", parameters);
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=tcp:thanhthu.database.windows.net,1433;Initial Catalog=E-Commerce;Persist Security Info=False;User ID=thanhthu;Password=Haha123@;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Category>(entity =>
            {
                entity.HasKey(e => e.IdCate);

                entity.ToTable("category");

                entity.Property(e => e.IdCate)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_cate");

                entity.Property(e => e.NameCate)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("name_cate");
            });

            modelBuilder.Entity<Contact>(entity =>
            {
                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.Property(e => e.FullName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Phone).HasMaxLength(50);
            });

            modelBuilder.Entity<Message>(entity =>
            {
                entity.HasKey(e => e.IdMessage)
                    .HasName("PK__messages__460F3CF43068CFE2");

                entity.ToTable("messages");

                entity.Property(e => e.IdMessage)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_message");

                entity.Property(e => e.Content)
                    .IsRequired()
                    .HasMaxLength(1000)
                    .HasColumnName("content");

                entity.Property(e => e.FromIdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("from_id_acc");

                entity.Property(e => e.Timestamp)
                    .HasColumnType("datetime")
                    .HasColumnName("timestamp");

                entity.Property(e => e.ToRoomId)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("to_room_Id");

                entity.HasOne(d => d.ToRoom)
                    .WithMany(p => p.Messages)
                    .HasForeignKey(d => d.ToRoomId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__messages__to_roo__2CBDA3B5");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.HasKey(e => e.IdOrder)
                    .HasName("PK_shop_order");

                entity.ToTable("order");

                entity.Property(e => e.IdOrder)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_order");

                entity.Property(e => e.IdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("id_acc");

                entity.Property(e => e.IdAddress)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_address");

                entity.Property(e => e.OrderDate)
                    .HasColumnType("datetime")
                    .HasColumnName("order_date");

                entity.Property(e => e.OrderEnd).HasColumnName("order_end");

                entity.Property(e => e.OrderInProgress).HasColumnName("order_in_progress");

                entity.Property(e => e.OrderStart).HasColumnName("order_start");

                entity.Property(e => e.OrderStatus).HasColumnName("order_status");

                entity.Property(e => e.OrderTotal).HasColumnName("order_total");

                entity.Property(e => e.PaymentMethodId).HasColumnName("payment_method_id");

                entity.HasOne(d => d.IdAccNavigation)
                    .WithMany(p => p.Orders)
                    .HasForeignKey(d => d.IdAcc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_order_Users");
            });

            modelBuilder.Entity<OrderDetail>(entity =>
            {
                entity.HasKey(e => e.IdOrderDetail)
                    .HasName("PK_order_line");

                entity.ToTable("order_detail");

                entity.Property(e => e.IdOrderDetail)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_order_detail");

                entity.Property(e => e.IdOrder)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_order");

                entity.Property(e => e.IdProItem)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro_item");

                entity.Property(e => e.OrderTotal).HasColumnName("order_total");

                entity.Property(e => e.Price).HasColumnName("price");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.HasOne(d => d.IdOrderNavigation)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.IdOrder)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_order_line_shop_order");

                entity.HasOne(d => d.IdProItemNavigation)
                    .WithMany(p => p.OrderDetails)
                    .HasForeignKey(d => d.IdProItem)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_order_detail_product_item");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.HasKey(e => e.IdPro);

                entity.ToTable("product");

                entity.Property(e => e.IdPro)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro");

                entity.Property(e => e.Description)
                    .IsRequired()
                    .HasMaxLength(500)
                    .HasColumnName("description");

                entity.Property(e => e.IdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("id_acc");

                entity.Property(e => e.IdCate)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_cate");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(150)
                    .HasColumnName("name");

                entity.Property(e => e.StatusPro).HasColumnName("status_pro");

                entity.HasOne(d => d.IdAccNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.IdAcc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_product_Users");

                entity.HasOne(d => d.IdCateNavigation)
                    .WithMany(p => p.Products)
                    .HasForeignKey(d => d.IdCate)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_product_category");
            });

            modelBuilder.Entity<ProductItem>(entity =>
            {
                entity.HasKey(e => e.IdProItem);

                entity.ToTable("product_item");

                entity.Property(e => e.IdProItem)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro_item");

                entity.Property(e => e.BestSeller)
                    .HasColumnName("best_seller")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.CreateDate)
                    .HasColumnType("date")
                    .HasColumnName("create_date");

                entity.Property(e => e.Discount)
                    .HasColumnName("discount")
                    .HasDefaultValueSql("((0))");

                entity.Property(e => e.IdPro)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro");

                entity.Property(e => e.Kind)
                    .HasMaxLength(1000)
                    .HasColumnName("kind");

                entity.Property(e => e.ProImg)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("pro_img");

                entity.Property(e => e.ProPrice).HasColumnName("pro_price");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.Property(e => e.StatusProItem).HasColumnName("status_proItem");

                entity.Property(e => e.UpdateDate)
                    .HasColumnType("date")
                    .HasColumnName("update_date");

                entity.HasOne(d => d.IdProNavigation)
                    .WithMany(p => p.ProductItems)
                    .HasForeignKey(d => d.IdPro)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_product_item_product");
            });

            modelBuilder.Entity<Review>(entity =>
            {
                entity.HasKey(e => e.IdReview);

                entity.ToTable("review");

                entity.Property(e => e.IdReview)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_review");

                entity.Property(e => e.Comment)
                    .HasMaxLength(500)
                    .HasColumnName("comment");

                entity.Property(e => e.IdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("id_acc");

                entity.Property(e => e.IdPro)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro");

                entity.Property(e => e.RatingValue).HasColumnName("rating_value");

                entity.HasOne(d => d.IdAccNavigation)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.IdAcc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_review_Users");

                entity.HasOne(d => d.IdProNavigation)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.IdPro)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_review_product");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.HasIndex(e => e.NormalizedName, "RoleNameIndex")
                    .IsUnique()
                    .HasFilter("([NormalizedName] IS NOT NULL)");

                entity.Property(e => e.Name).HasMaxLength(256);

                entity.Property(e => e.NormalizedName).HasMaxLength(256);
            });

            modelBuilder.Entity<RoleClaim>(entity =>
            {
                entity.HasIndex(e => e.RoleId, "IX_RoleClaims_RoleId");

                entity.Property(e => e.RoleId).IsRequired();

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.RoleClaims)
                    .HasForeignKey(d => d.RoleId);
            });

            modelBuilder.Entity<RoomChat>(entity =>
            {
                entity.HasKey(e => e.IdRoom)
                    .HasName("PK__room_cha__3D497891DA28634D");

                entity.ToTable("room_chat");

                entity.Property(e => e.IdRoom)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_room");

                entity.Property(e => e.IdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("id_acc");

                entity.Property(e => e.RoomName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .HasColumnName("room_name");

                entity.HasOne(d => d.IdAccNavigation)
                    .WithMany(p => p.RoomChats)
                    .HasForeignKey(d => d.IdAcc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_room_chat_Users");
            });

            modelBuilder.Entity<ShoppingCart>(entity =>
            {
                entity.HasKey(e => e.IdCart);

                entity.ToTable("shopping_cart");

                entity.Property(e => e.IdCart)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_cart");

                entity.Property(e => e.IdAcc)
                    .IsRequired()
                    .HasMaxLength(450)
                    .HasColumnName("id_acc");

                entity.HasOne(d => d.IdAccNavigation)
                    .WithMany(p => p.ShoppingCarts)
                    .HasForeignKey(d => d.IdAcc)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_shopping_cart_Users");
            });

            modelBuilder.Entity<ShoppingCartItem>(entity =>
            {
                entity.HasKey(e => e.IdCartItem);

                entity.ToTable("shopping_cart_item");

                entity.Property(e => e.IdCartItem)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_cart_item");

                entity.Property(e => e.IdCart)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_cart");

                entity.Property(e => e.IdProItem)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro_item");

                entity.Property(e => e.Price).HasColumnName("price");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.HasOne(d => d.IdCartNavigation)
                    .WithMany(p => p.ShoppingCartItems)
                    .HasForeignKey(d => d.IdCart)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_shopping_cart_item_shopping_cart");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.HasIndex(e => e.NormalizedEmail, "EmailIndex");

                entity.HasIndex(e => e.NormalizedUserName, "UserNameIndex")
                    .IsUnique()
                    .HasFilter("([NormalizedUserName] IS NOT NULL)");

                entity.Property(e => e.Email).HasMaxLength(256);

                entity.Property(e => e.FullName).HasMaxLength(400);

                entity.Property(e => e.HomeAdress).HasMaxLength(400);

                entity.Property(e => e.NormalizedEmail).HasMaxLength(256);

                entity.Property(e => e.NormalizedUserName).HasMaxLength(256);

                entity.Property(e => e.UserName).HasMaxLength(256);
            });

            modelBuilder.Entity<UserClaim>(entity =>
            {
                entity.HasIndex(e => e.UserId, "IX_UserClaims_UserId");

                entity.Property(e => e.UserId).IsRequired();

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserClaims)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<UserLogin>(entity =>
            {
                entity.HasKey(e => new { e.LoginProvider, e.ProviderKey });

                entity.HasIndex(e => e.UserId, "IX_UserLogins_UserId");

                entity.Property(e => e.UserId).IsRequired();

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserLogins)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.RoleId });

                entity.HasIndex(e => e.RoleId, "IX_UserRoles_RoleId");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.UserRoles)
                    .HasForeignKey(d => d.RoleId);

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserRoles)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<UserToken>(entity =>
            {
                entity.HasKey(e => new { e.UserId, e.LoginProvider, e.Name });

                entity.HasOne(d => d.User)
                    .WithMany(p => p.UserTokens)
                    .HasForeignKey(d => d.UserId);
            });

            modelBuilder.Entity<Voucher>(entity =>
            {
                entity.ToTable("voucher");

                entity.HasIndex(e => e.PromotionCode, "UQ__voucher__888755056DDE6B48")
                    .IsUnique();

                entity.Property(e => e.VoucherId)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("voucher_id");

                entity.Property(e => e.DeleteStatus).HasColumnName("delete_status");

                entity.Property(e => e.DiscountAmount).HasColumnName("discount_amount");

                entity.Property(e => e.DiscountType).HasColumnName("discount_type");

                entity.Property(e => e.EndDate)
                    .HasColumnType("date")
                    .HasColumnName("end_date");

                entity.Property(e => e.MaxiValue).HasColumnName("maxi_value");

                entity.Property(e => e.MinValue).HasColumnName("min_value");

                entity.Property(e => e.PromotionCode)
                    .IsRequired()
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("promotion_code");

                entity.Property(e => e.PromotionName)
                    .IsRequired()
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("promotion_name");

                entity.Property(e => e.Quantity).HasColumnName("quantity");

                entity.Property(e => e.StartDate)
                    .HasColumnType("date")
                    .HasColumnName("start_date");

                entity.Property(e => e.UsageStatus).HasColumnName("usage_status");
            });

            modelBuilder.Entity<Wishlist>(entity =>
            {
                entity.HasKey(e => e.IdWishlist);

                entity.ToTable("wishlist");

                entity.Property(e => e.IdWishlist)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_wishlist");

                entity.Property(e => e.IdPro)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("id_pro");

                entity.HasOne(d => d.IdProNavigation)
                    .WithMany(p => p.Wishlists)
                    .HasForeignKey(d => d.IdPro)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_wishlist_product");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
