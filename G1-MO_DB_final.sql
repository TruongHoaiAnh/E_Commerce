/****** Object:  Table [dbo].[Banners]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Banners](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[link] [nvarchar](50) NOT NULL,
	[text] [nvarchar](max) NULL,
 CONSTRAINT [PK_Banners] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id_cate] [varchar](50) NOT NULL,
	[name_cate] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[id_cate] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[DateSent] [datetime2](7) NOT NULL,
	[Message] [nvarchar](max) NULL,
	[Phone] [nvarchar](50) NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[img_pro]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[img_pro](
	[id_img] [nvarchar](50) NOT NULL,
	[id_pro] [varchar](50) NOT NULL,
	[link_img] [nvarchar](max) NULL,
 CONSTRAINT [PK_img_pro] PRIMARY KEY CLUSTERED 
(
	[id_img] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Messages]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Messages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[Timestamp] [datetime2](7) NOT NULL,
	[ToRoomId] [int] NOT NULL,
	[FromUserId] [nvarchar](450) NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[id_order] [varchar](50) NOT NULL,
	[id_acc] [nvarchar](450) NOT NULL,
	[order_date] [datetime] NOT NULL,
	[payment_method_id] [int] NOT NULL,
	[address] [nvarchar](450) NOT NULL,
	[order_total] [float] NOT NULL,
	[order_status] [int] NOT NULL,
	[order_start] [int] NULL,
	[order_in_progress] [int] NULL,
	[order_end] [int] NULL,
	[phone] [nvarchar](50) NULL,
	[fullname] [nvarchar](450) NULL,
	[email] [nvarchar](450) NULL,
 CONSTRAINT [PK_shop_order] PRIMARY KEY CLUSTERED 
(
	[id_order] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[id_order_detail] [varchar](50) NOT NULL,
	[id_pro_item] [varchar](50) NOT NULL,
	[id_order] [varchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
	[order_total] [float] NOT NULL,
	[id_seller] [nvarchar](450) NULL,
 CONSTRAINT [PK_order_line] PRIMARY KEY CLUSTERED 
(
	[id_order_detail] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id_pro] [varchar](50) NOT NULL,
	[name] [nvarchar](150) NOT NULL,
	[description] [nvarchar](500) NOT NULL,
	[id_cate] [varchar](50) NOT NULL,
	[id_acc] [nvarchar](450) NOT NULL,
	[status_pro] [int] NOT NULL,
	[create_date] [datetime] NULL,
	[update_date] [datetime] NULL,
	[best_saler] [int] NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id_pro] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_item]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_item](
	[id_pro_item] [varchar](50) NOT NULL,
	[id_pro] [varchar](50) NOT NULL,
	[name] [varchar](50) NULL,
	[quantity] [int] NOT NULL,
	[pro_price] [float] NOT NULL,
	[discount] [float] NULL,
	[status_proItem] [int] NULL,
 CONSTRAINT [PK_product_item] PRIMARY KEY CLUSTERED 
(
	[id_pro_item] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[review]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[review](
	[id_review] [varchar](50) NOT NULL,
	[id_acc] [nvarchar](450) NOT NULL,
	[id_pro] [varchar](50) NOT NULL,
	[rating_value] [float] NOT NULL,
	[comment] [nvarchar](500) NULL,
	[review_date] [datetime] NULL,
 CONSTRAINT [PK_review] PRIMARY KEY CLUSTERED 
(
	[id_review] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[AdminId] [nvarchar](450) NULL,
	[User2Id] [nvarchar](450) NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shopping_cart]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shopping_cart](
	[id_cart] [varchar](50) NOT NULL,
	[id_acc] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_shopping_cart] PRIMARY KEY CLUSTERED 
(
	[id_cart] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shopping_cart_item]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shopping_cart_item](
	[id_cart_item] [varchar](50) NOT NULL,
	[id_cart] [varchar](50) NOT NULL,
	[id_pro_item] [varchar](50) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NULL,
	[id_pro] [varchar](50) NULL,
 CONSTRAINT [PK_shopping_cart_item] PRIMARY KEY CLUSTERED 
(
	[id_cart_item] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](450) NOT NULL,
	[HomeAdress] [nvarchar](400) NULL,
	[BirthDate] [datetime2](7) NULL,
	[Gender] [int] NOT NULL,
	[DateCreate] [datetime2](7) NULL,
	[LastLogin] [datetime2](7) NULL,
	[BlockDate] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[FullName] [nvarchar](400) NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Avt] [nvarchar](max) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[voucher]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher](
	[voucher_id] [varchar](100) NOT NULL,
	[promotion_code] [varchar](100) NOT NULL,
	[promotion_name] [varchar](255) NOT NULL,
	[discount_type] [int] NOT NULL,
	[discount_amount] [float] NOT NULL,
	[maxi_value] [float] NULL,
	[min_value] [float] NULL,
	[quantity] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[usage_status] [int] NOT NULL,
	[delete_status] [bit] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[promotion_code] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	[id_wishlist] [varchar](50) NOT NULL,
	[id_pro] [varchar](50) NOT NULL,
	[id_acc] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_wishlist] PRIMARY KEY CLUSTERED 
(
	[id_wishlist] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_item] ADD  DEFAULT ((0)) FOR [discount]
GO
ALTER TABLE [dbo].[img_pro]  WITH CHECK ADD  CONSTRAINT [FK_img_pro_product] FOREIGN KEY([id_pro])
REFERENCES [dbo].[product] ([id_pro])
GO
ALTER TABLE [dbo].[img_pro] CHECK CONSTRAINT [FK_img_pro_product]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_AspNetUsers_FromUserId] FOREIGN KEY([FromUserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_AspNetUsers_FromUserId]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Rooms_ToRoomId] FOREIGN KEY([ToRoomId])
REFERENCES [dbo].[Rooms] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Rooms_ToRoomId]
GO
ALTER TABLE [dbo].[order]  WITH NOCHECK ADD  CONSTRAINT [FK_order_Users] FOREIGN KEY([id_acc])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_Users]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [FK_order_detail_product_item] FOREIGN KEY([id_pro_item])
REFERENCES [dbo].[product_item] ([id_pro_item])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [FK_order_detail_product_item]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [FK_order_detail_UserSeller] FOREIGN KEY([id_seller])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [FK_order_detail_UserSeller]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD  CONSTRAINT [FK_order_line_shop_order] FOREIGN KEY([id_order])
REFERENCES [dbo].[order] ([id_order])
GO
ALTER TABLE [dbo].[order_detail] CHECK CONSTRAINT [FK_order_line_shop_order]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([id_cate])
REFERENCES [dbo].[category] ([id_cate])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product]  WITH NOCHECK ADD  CONSTRAINT [FK_product_Users] FOREIGN KEY([id_acc])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_Users]
GO
ALTER TABLE [dbo].[product_item]  WITH CHECK ADD  CONSTRAINT [FK_product_item_product] FOREIGN KEY([id_pro])
REFERENCES [dbo].[product] ([id_pro])
GO
ALTER TABLE [dbo].[product_item] CHECK CONSTRAINT [FK_product_item_product]
GO
ALTER TABLE [dbo].[review]  WITH CHECK ADD  CONSTRAINT [FK_review_product] FOREIGN KEY([id_pro])
REFERENCES [dbo].[product] ([id_pro])
GO
ALTER TABLE [dbo].[review] CHECK CONSTRAINT [FK_review_product]
GO
ALTER TABLE [dbo].[review]  WITH NOCHECK ADD  CONSTRAINT [FK_review_Users] FOREIGN KEY([id_acc])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[review] CHECK CONSTRAINT [FK_review_Users]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Rooms_AspNetUsers_AdminId] FOREIGN KEY([AdminId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Rooms_AspNetUsers_AdminId]
GO
ALTER TABLE [dbo].[Rooms]  WITH CHECK ADD  CONSTRAINT [FK_Rooms_Users] FOREIGN KEY([User2Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Rooms] CHECK CONSTRAINT [FK_Rooms_Users]
GO
ALTER TABLE [dbo].[shopping_cart]  WITH NOCHECK ADD  CONSTRAINT [FK_shopping_cart_Users] FOREIGN KEY([id_acc])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[shopping_cart] CHECK CONSTRAINT [FK_shopping_cart_Users]
GO
ALTER TABLE [dbo].[shopping_cart_item]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_item_product] FOREIGN KEY([id_pro])
REFERENCES [dbo].[product] ([id_pro])
GO
ALTER TABLE [dbo].[shopping_cart_item] CHECK CONSTRAINT [FK_shopping_cart_item_product]
GO
ALTER TABLE [dbo].[shopping_cart_item]  WITH NOCHECK ADD  CONSTRAINT [FK_shopping_cart_item_product_item] FOREIGN KEY([id_pro_item])
REFERENCES [dbo].[product_item] ([id_pro_item])
GO
ALTER TABLE [dbo].[shopping_cart_item] CHECK CONSTRAINT [FK_shopping_cart_item_product_item]
GO
ALTER TABLE [dbo].[shopping_cart_item]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_item_shopping_cart] FOREIGN KEY([id_cart])
REFERENCES [dbo].[shopping_cart] ([id_cart])
GO
ALTER TABLE [dbo].[shopping_cart_item] CHECK CONSTRAINT [FK_shopping_cart_item_shopping_cart]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserTokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserTokens] CHECK CONSTRAINT [FK_UserTokens_Users_UserId]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD  CONSTRAINT [FK_wishlist_product] FOREIGN KEY([id_pro])
REFERENCES [dbo].[product] ([id_pro])
GO
ALTER TABLE [dbo].[wishlist] CHECK CONSTRAINT [FK_wishlist_product]
GO
ALTER TABLE [dbo].[wishlist]  WITH CHECK ADD  CONSTRAINT [FK_wishlist_Users] FOREIGN KEY([id_acc])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[wishlist] CHECK CONSTRAINT [FK_wishlist_Users]
GO
/****** Object:  StoredProcedure [dbo].[GetAccountBuyerCountByYear]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountBuyerCountByYear]
    @Year INT
AS
BEGIN
    DECLARE @Month INT = 1
    DECLARE @Results TABLE (
        Year INT,
        Month INT,
        AccountCount INT
    )
    
    -- Duyệt qua từng tháng trong năm được chỉ định
    WHILE @Month <= 12
    BEGIN
        INSERT INTO @Results (Year, Month, AccountCount)
        SELECT @Year, @Month, COUNT(*)
        FROM Users as u
        
        JOIN 
        UserRoles ur ON u.Id = ur.UserId
        JOIN 
        Roles r ON ur.RoleId = r.Id AND r.Name = 'Buyer'
        Where
        MONTH(u.DateCreate) = @Month AND YEAR(u.DateCreate) = @Year and u.[Status] = 1
        
        SET @Month = @Month + 1
    END
    
    -- Trả về kết quả
    SELECT * FROM @Results
    ORDER BY Year, Month
END
GO
/****** Object:  StoredProcedure [dbo].[GetAccountDisableByYear]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountDisableByYear]
    @Year INT
AS
BEGIN
    DECLARE @Month INT = 1
    DECLARE @Results TABLE (
        Year INT,
        Month INT,
        AccountCount INT
    )
    
    -- Duyệt qua từng tháng trong năm được chỉ định
    WHILE @Month <= 12
    BEGIN
        INSERT INTO @Results (Year, Month, AccountCount)
        SELECT @Year, @Month, COUNT(*)
        FROM Users as u
        
        JOIN 
        UserRoles ur ON u.Id = ur.UserId
        JOIN 
        Roles r ON ur.RoleId = r.Id AND r.Name <> 'Administrator'
        Where
        MONTH(u.BlockDate) = @Month AND YEAR(u.BlockDate) = @Year and u.[Status] = 0
        
        SET @Month = @Month + 1
    END
    
    -- Trả về kết quả
    SELECT * FROM @Results
    ORDER BY Year, Month
END
GO
/****** Object:  StoredProcedure [dbo].[GetAccountSellerCountByYear]    Script Date: 3/16/2024 10:47:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAccountSellerCountByYear]
    @Year INT
AS
BEGIN
    DECLARE @Month INT = 1
    DECLARE @Results TABLE (
        Year INT,
        Month INT,
        AccountCount INT
    )
    
    -- Duyệt qua từng tháng trong năm được chỉ định
    WHILE @Month <= 12
    BEGIN
        INSERT INTO @Results (Year, Month, AccountCount)
        SELECT @Year, @Month, COUNT(*)
        FROM Users as u
        
        JOIN 
        UserRoles ur ON u.Id = ur.UserId
        JOIN 
        Roles r ON ur.RoleId = r.Id AND r.Name = 'Seller'
        Where
        MONTH(u.DateCreate) = @Month AND YEAR(u.DateCreate) = @Year AND u.[Status] = 1
        
        SET @Month = @Month + 1
    END
    
    -- Trả về kết quả
    SELECT * FROM @Results
    ORDER BY Year, Month
END
GO
