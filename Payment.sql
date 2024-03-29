USE [Payment]
GO
/****** Object:  Schema [HangFire]    Script Date: 3/12/2024 1:03:59 PM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[Merchant]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Merchant](
	[MerchantId] [nvarchar](50) NOT NULL,
	[MerchantName] [nvarchar](250) NULL,
	[MerchantWebLink] [nvarchar](250) NULL,
	[MerchantIpnUrl] [nvarchar](250) NULL,
	[MerchantReturnUrl] [nvarchar](250) NULL,
	[SecretKey] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdateAt] [datetime] NULL,
 CONSTRAINT [PK_Merchant] PRIMARY KEY CLUSTERED 
(
	[MerchantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentId] [nvarchar](50) NOT NULL,
	[PaymentContent] [nvarchar](250) NULL,
	[PaymentCurrency] [nvarchar](10) NULL,
	[PaymentRefId] [nvarchar](50) NULL,
	[RequiredAmount] [decimal](19, 2) NULL,
	[PaymentDate] [datetime] NULL,
	[ExpireDate] [datetime] NULL,
	[PaymentLanguage] [nvarchar](10) NULL,
	[MerchantId] [nvarchar](50) NULL,
	[DestId] [nvarchar](50) NULL,
	[PaidAmount] [decimal](19, 2) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[PaymentLastMessage] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[LastUpdatedBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdatedAt] [nchar](10) NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentDestination]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentDestination](
	[DesId] [nvarchar](50) NOT NULL,
	[DesLogo] [nvarchar](250) NULL,
	[DesShortName] [nvarchar](50) NULL,
	[DesName] [nvarchar](250) NULL,
	[DesSortIndex] [int] NULL,
	[ParentId] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdateAt] [datetime] NULL,
 CONSTRAINT [PK_PaymentDestination] PRIMARY KEY CLUSTERED 
(
	[DesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentNotification]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentNotification](
	[NotiId] [nvarchar](50) NOT NULL,
	[PaymentRefId] [nvarchar](50) NULL,
	[NotiDate] [datetime] NULL,
	[NotiAmount] [nvarchar](50) NULL,
	[NotiContent] [nvarchar](50) NULL,
	[NotiMessage] [nvarchar](50) NULL,
	[NotiSignature] [nvarchar](50) NULL,
	[PaymentId] [nvarchar](50) NULL,
	[MerchantId] [nvarchar](50) NULL,
	[NotiStatus] [nvarchar](50) NULL,
	[NotiResDate] [nvarchar](50) NULL,
 CONSTRAINT [PK_PaymentNotification] PRIMARY KEY CLUSTERED 
(
	[NotiId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentSignature]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentSignature](
	[SignId] [nvarchar](50) NOT NULL,
	[SignValue] [nvarchar](500) NULL,
	[SignAlgo] [nvarchar](50) NULL,
	[SignDate] [datetime] NULL,
	[SignOwn] [nvarchar](50) NULL,
	[PaymentId] [nvarchar](50) NULL,
	[IsValid] [bit] NULL,
 CONSTRAINT [PK_PaymentSignature] PRIMARY KEY CLUSTERED 
(
	[SignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentTransaction]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentTransaction](
	[TransId] [nvarchar](50) NOT NULL,
	[TransMessage] [nvarchar](250) NULL,
	[TransPayload] [nvarchar](500) NULL,
	[TransStatus] [nvarchar](10) NULL,
	[TransAmount] [decimal](19, 2) NULL,
	[TransDate] [datetime] NULL,
	[PaymentId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[LastUpdateBy] [nvarchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[LastUpdateAt] [datetime] NULL,
 CONSTRAINT [PK_PaymentTransaction] PRIMARY KEY CLUSTERED 
(
	[TransId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_HangFire_Counter] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Job]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[List]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Server]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](200) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[Set]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [HangFire].[State]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Merchant] ([MerchantId], [MerchantName], [MerchantWebLink], [MerchantIpnUrl], [MerchantReturnUrl], [SecretKey], [IsActive], [CreatedBy], [LastUpdateBy], [CreatedAt], [LastUpdateAt]) VALUES (N'MER0001', N'TEST', NULL, NULL, N'http://localhost:5000', NULL, 1, N'TEST', NULL, CAST(N'2024-03-10T20:54:11.020' AS DateTime), NULL)
INSERT [dbo].[Merchant] ([MerchantId], [MerchantName], [MerchantWebLink], [MerchantIpnUrl], [MerchantReturnUrl], [SecretKey], [IsActive], [CreatedBy], [LastUpdateBy], [CreatedAt], [LastUpdateAt]) VALUES (N'MER0002', N'TEST', NULL, NULL, NULL, NULL, 1, N'TEST', NULL, CAST(N'2024-03-10T20:54:11.020' AS DateTime), NULL)
GO
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'', NULL, NULL, NULL, NULL, CAST(N'2024-03-10T22:09:10.290' AS DateTime), CAST(N'2024-03-10T22:24:10.290' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:09:10.290' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457066760909297', N'Thanh toan don hang', N'VND', N'ORD1234', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-10T22:31:16.090' AS DateTime), CAST(N'2024-03-10T22:46:16.090' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:31:16.090' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457069058714506', N'Thanh toan don hang', N'VND', N'ORD1234', CAST(100000.00 AS Decimal(19, 2)), CAST(N'2024-03-10T22:35:05.870' AS DateTime), CAST(N'2024-03-10T22:50:05.870' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:35:05.873' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457073760439831', N'Thanh toan don hang', N'VND', N'ORD1234', CAST(1000000.00 AS Decimal(19, 2)), CAST(N'2024-03-10T22:42:56.043' AS DateTime), CAST(N'2024-03-10T22:57:56.043' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:42:56.050' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457076369218341', N'Thanh toan don hang', N'VND', N'ORD1234', CAST(1000000.00 AS Decimal(19, 2)), CAST(N'2024-03-10T22:47:16.923' AS DateTime), CAST(N'2024-03-10T23:02:16.923' AS DateTime), N'vn', N'MER0002', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:47:16.923' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457082095428523', N'Thanh toan don hang', N'VND', N'ORD1234', CAST(100000.00 AS Decimal(19, 2)), CAST(N'2024-03-10T22:56:49.543' AS DateTime), CAST(N'2024-03-10T23:11:49.543' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-10T22:56:49.553' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457615293068779', N'string', N'string', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T13:45:29.307' AS DateTime), CAST(N'2024-03-11T14:00:29.307' AS DateTime), N'string', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T13:45:29.360' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457626213154758', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:03:41.317' AS DateTime), CAST(N'2024-03-11T14:18:41.317' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:03:41.320' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457627841475280', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:06:24.147' AS DateTime), CAST(N'2024-03-11T14:21:24.147' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:06:24.147' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628826050000', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:02.607' AS DateTime), CAST(N'2024-03-11T14:23:02.607' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:02.607' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628838998461', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:03.900' AS DateTime), CAST(N'2024-03-11T14:23:03.900' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:03.897' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628840999403', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:04.100' AS DateTime), CAST(N'2024-03-11T14:23:04.100' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:04.097' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628842869135', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:04.287' AS DateTime), CAST(N'2024-03-11T14:23:04.287' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:04.283' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628847588583', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:04.760' AS DateTime), CAST(N'2024-03-11T14:23:04.760' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:04.757' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628849320143', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:04.933' AS DateTime), CAST(N'2024-03-11T14:23:04.933' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:04.930' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628850990921', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:05.100' AS DateTime), CAST(N'2024-03-11T14:23:05.100' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:05.097' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628852530894', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:05.253' AS DateTime), CAST(N'2024-03-11T14:23:05.253' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:05.250' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628854385837', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:05.440' AS DateTime), CAST(N'2024-03-11T14:23:05.440' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:05.437' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457628856247354', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:05.623' AS DateTime), CAST(N'2024-03-11T14:23:05.623' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:05.623' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457629022127511', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:08:22.213' AS DateTime), CAST(N'2024-03-11T14:23:22.213' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:08:22.213' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457634152684013', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:16:55.270' AS DateTime), CAST(N'2024-03-11T14:31:55.270' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:16:55.270' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457635537248863', N'string', N'string', N'string', CAST(100000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:19:13.723' AS DateTime), CAST(N'2024-03-11T14:34:13.723' AS DateTime), N'string', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:19:13.727' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457644285090140', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:33:48.510' AS DateTime), CAST(N'2024-03-11T14:48:48.510' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:33:48.513' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457644561245632', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:34:16.123' AS DateTime), CAST(N'2024-03-11T14:49:16.123' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:34:16.120' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457645445683266', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:35:44.567' AS DateTime), CAST(N'2024-03-11T14:50:44.567' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:35:44.570' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457645511658247', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:35:51.167' AS DateTime), CAST(N'2024-03-11T14:50:51.167' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:35:51.167' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457648110194383', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:40:11.020' AS DateTime), CAST(N'2024-03-11T14:55:11.020' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:40:11.020' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457648256756946', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T14:40:25.677' AS DateTime), CAST(N'2024-03-11T14:55:25.677' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T14:40:25.673' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457660393732759', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T15:00:39.373' AS DateTime), CAST(N'2024-03-11T15:15:39.373' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T15:00:39.377' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457663588850971', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T15:05:58.887' AS DateTime), CAST(N'2024-03-11T15:20:58.887' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T15:05:58.890' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457899690334761', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T21:39:29.033' AS DateTime), CAST(N'2024-03-11T21:54:29.033' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T21:39:29.087' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457903173013584', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T21:45:17.300' AS DateTime), CAST(N'2024-03-11T22:00:17.300' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T21:45:17.303' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457904498983859', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T21:47:29.900' AS DateTime), CAST(N'2024-03-11T22:02:29.900' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T21:47:29.900' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457910118122988', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T21:56:51.813' AS DateTime), CAST(N'2024-03-11T22:11:51.813' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T21:56:51.823' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457933751079519', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:36:15.107' AS DateTime), CAST(N'2024-03-11T22:51:15.107' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:36:15.137' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457934298634307', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:37:09.863' AS DateTime), CAST(N'2024-03-11T22:52:09.863' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:37:09.863' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457935248161544', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:38:44.817' AS DateTime), CAST(N'2024-03-11T22:53:44.817' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:38:44.820' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457938054621996', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:43:25.463' AS DateTime), CAST(N'2024-03-11T22:58:25.463' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:43:25.477' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457939364534503', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:45:36.453' AS DateTime), CAST(N'2024-03-11T23:00:36.453' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:45:36.457' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457940099298584', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:46:49.930' AS DateTime), CAST(N'2024-03-11T23:01:49.930' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:46:49.930' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457940134729587', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:46:53.473' AS DateTime), CAST(N'2024-03-11T23:01:53.473' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:46:53.470' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457940209321856', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:47:00.933' AS DateTime), CAST(N'2024-03-11T23:02:00.933' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:47:00.930' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457940566296708', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:47:36.630' AS DateTime), CAST(N'2024-03-11T23:02:36.630' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:47:36.633' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457941067788574', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:48:26.780' AS DateTime), CAST(N'2024-03-11T23:03:26.780' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:48:26.777' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457942062339558', N'Thanh toan', N'VND', N'ORD123', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T22:50:06.233' AS DateTime), CAST(N'2024-03-11T23:05:06.233' AS DateTime), N'vn', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T22:50:06.240' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457954197793163', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T23:10:19.780' AS DateTime), CAST(N'2024-03-11T23:25:19.780' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T23:10:19.780' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457955149561061', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T23:11:54.957' AS DateTime), CAST(N'2024-03-11T23:26:54.957' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T23:11:54.957' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457958478337005', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T23:17:27.833' AS DateTime), CAST(N'2024-03-11T23:32:27.833' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T23:17:27.840' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457959766910652', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T23:19:36.690' AS DateTime), CAST(N'2024-03-11T23:34:36.690' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T23:19:36.693' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457961837119592', N'Thanh toan don hang ABC', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-11T23:23:03.713' AS DateTime), CAST(N'2024-03-11T23:38:03.713' AS DateTime), N'', N'MER0001', N'VNPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-11T23:23:03.717' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457990800008223', N'Thanh toan don hang ABC MoMo', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T00:11:20.000' AS DateTime), CAST(N'2024-03-12T00:26:20.000' AS DateTime), N'', N'MER0001', N'MOMO', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T00:11:20.053' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457992188216354', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T00:13:38.820' AS DateTime), CAST(N'2024-03-12T00:28:38.820' AS DateTime), N'', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T00:13:38.823' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638457992321907844', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T00:13:52.190' AS DateTime), CAST(N'2024-03-12T00:28:52.190' AS DateTime), N'', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T00:13:52.190' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458030864758200', N'string', N'string', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:18:06.477' AS DateTime), CAST(N'2024-03-12T01:33:06.477' AS DateTime), N'string', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:18:06.480' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458032201404076', N'string', N'string', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:20:20.140' AS DateTime), CAST(N'2024-03-12T01:35:20.140' AS DateTime), N'string', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:20:20.150' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458032250915584', N'string', N'string', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:20:25.090' AS DateTime), CAST(N'2024-03-12T01:35:25.090' AS DateTime), N'string', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:20:25.097' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458033939547651', N'string', N'string', N'string', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:23:13.953' AS DateTime), CAST(N'2024-03-12T01:38:13.953' AS DateTime), N'vn', N'MER0001', N'ZALOPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:23:13.957' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458034085940408', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:23:28.593' AS DateTime), CAST(N'2024-03-12T01:38:28.593' AS DateTime), N'', N'MER0001', N'ZaloPay', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:23:28.590' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458034236315912', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:23:43.630' AS DateTime), CAST(N'2024-03-12T01:38:43.630' AS DateTime), N'', N'MER0001', N'ZALOPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:23:43.633' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458034574334100', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:24:17.433' AS DateTime), CAST(N'2024-03-12T01:39:17.433' AS DateTime), N'', N'MER0001', N'ZALOPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:24:17.430' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458036670611842', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:27:47.060' AS DateTime), CAST(N'2024-03-12T01:42:47.060' AS DateTime), N'', N'MER0001', N'ZALOPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:27:47.063' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458038085495688', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:30:08.550' AS DateTime), CAST(N'2024-03-12T01:45:08.550' AS DateTime), N'', N'MER0001', N'ZALOPAY', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:30:08.550' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458039461843498', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:32:26.183' AS DateTime), CAST(N'2024-03-12T01:47:26.183' AS DateTime), N'', N'MER0001', N'MOMO', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:32:26.187' AS DateTime), NULL)
INSERT [dbo].[Payment] ([PaymentId], [PaymentContent], [PaymentCurrency], [PaymentRefId], [RequiredAmount], [PaymentDate], [ExpireDate], [PaymentLanguage], [MerchantId], [DestId], [PaidAmount], [PaymentStatus], [PaymentLastMessage], [CreatedBy], [LastUpdatedBy], [CreatedAt], [LastUpdatedAt]) VALUES (N'638458041950581706', N'Thanh toan don hang ABC ZaloPay', N'VND', N'Ma don hang', CAST(10000.00 AS Decimal(19, 2)), CAST(N'2024-03-12T01:36:35.057' AS DateTime), CAST(N'2024-03-12T01:51:35.057' AS DateTime), N'', N'MER0001', N'MOMO', NULL, NULL, NULL, N'', NULL, CAST(N'2024-03-12T01:36:35.060' AS DateTime), NULL)
GO
INSERT [dbo].[PaymentDestination] ([DesId], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [LastUpdateBy], [CreatedAt], [LastUpdateAt]) VALUES (N'MOMO', N'', N'MOMO', N'Vi dien tu MoMo', 1, NULL, NULL, N'Admin', NULL, CAST(N'2024-03-10T20:54:11.020' AS DateTime), NULL)
INSERT [dbo].[PaymentDestination] ([DesId], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [LastUpdateBy], [CreatedAt], [LastUpdateAt]) VALUES (N'VNPAY', N'https://sandbox.vnpaypayment.vn/apis/assets/images/partner_app.png', N'VNPAY', N'Cong thanh toan VNPAY', 0, NULL, NULL, N'Admin', NULL, CAST(N'2024-03-10T20:54:11.020' AS DateTime), NULL)
INSERT [dbo].[PaymentDestination] ([DesId], [DesLogo], [DesShortName], [DesName], [DesSortIndex], [ParentId], [IsActive], [CreatedBy], [LastUpdateBy], [CreatedAt], [LastUpdateAt]) VALUES (N'ZALOPAY', NULL, N'ZALOPAY', N'Vi dien tu ZaloPay', 1, NULL, NULL, N'Admin', NULL, CAST(N'2024-03-10T20:54:11.020' AS DateTime), NULL)
GO
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'0A29F57B-3A17-494D-A167-6913237B9E29', N'12345ABCDE', NULL, CAST(N'2024-03-12T00:11:20.057' AS DateTime), N'MER0001', N'638457990800008223', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'0A423F5F-0313-4268-9CC2-4012FBE253B3', N'12345ABCD', NULL, CAST(N'2024-03-11T22:38:44.823' AS DateTime), N'MER0001', N'638457935248161544', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'10AE4EEA-B23D-4114-8E94-107F82C4DF58', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:30:08.553' AS DateTime), N'MER0001', N'638458038085495688', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'14FC6C52-2508-4511-A463-3EB39207C260', N'string', NULL, CAST(N'2024-03-12T01:20:25.100' AS DateTime), N'MER0001', N'638458032250915584', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'15065A11-1281-45FF-BD21-0F0C6FD9157F', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:40:25.673' AS DateTime), N'MER0001', N'638457648256756946', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'19DD5057-1862-4A66-9AEA-3E862AA131EA', N'12345ABCD', NULL, CAST(N'2024-03-11T22:46:53.483' AS DateTime), N'MER0001', N'638457940134729587', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'1FA36B0F-9E2C-4FE3-A1D1-4523A9BD1B17', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:05.437' AS DateTime), N'MER0001', N'638457628854385837', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'237A1385-EE91-4B42-A4A3-8900EC607203', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:34:16.130' AS DateTime), N'MER0001', N'638457644561245632', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'25816488-70EA-402A-9779-5AD66E0A8C6F', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:06:24.150' AS DateTime), N'MER0001', N'638457627841475280', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'28256896-5D95-42E4-82BB-F52E1361D9D4', N'12345ABCD', NULL, CAST(N'2024-03-11T22:43:25.490' AS DateTime), N'MER0001', N'638457938054621996', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'2927F6D9-726E-48E4-8739-9A7887BAB2E7', N'12345ABCDE', NULL, CAST(N'2024-03-11T21:39:29.087' AS DateTime), N'MER0001', N'638457899690334761', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'3512BEE8-71DA-450F-A90C-BC1036B73F28', N'12345ABCDE', NULL, CAST(N'2024-03-11T21:56:51.827' AS DateTime), N'MER0001', N'638457910118122988', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'3528438D-360F-4F2D-9418-BD7856A128A0', N'12345ABCDE', NULL, CAST(N'2024-03-11T21:45:17.303' AS DateTime), N'MER0001', N'638457903173013584', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'3550D32F-0631-44AA-A980-F526D37F40EE', N'12345ABCDE', NULL, CAST(N'2024-03-11T23:11:54.960' AS DateTime), N'MER0001', N'638457955149561061', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'3A41F785-3BFA-4BE2-8E9F-508C2BB1AAF0', N'12345ABCDE', NULL, CAST(N'2024-03-11T21:47:29.900' AS DateTime), N'MER0001', N'638457904498983859', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'3D4EE42F-9AC8-467C-AD27-3E0EDA311970', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:04.287' AS DateTime), N'MER0001', N'638457628842869135', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'425F019C-10E6-4EC6-9924-16D53BC718EB', N'12345ABCD', NULL, CAST(N'2024-03-10T22:56:49.553' AS DateTime), N'MER0001', N'638457082095428523', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'45059B3B-C2D9-44AC-8848-4488E675D618', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:04.757' AS DateTime), N'MER0001', N'638457628847588583', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4AB0B364-A5D1-46FD-8941-5321112357CC', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:02.607' AS DateTime), N'MER0001', N'638457628826050000', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4AD048B1-CBFF-4500-B8C0-DDE80B6B7A92', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:03:41.320' AS DateTime), N'MER0001', N'638457626213154758', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4DD19A54-2528-49FB-AC86-F1339C18D8B9', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:24:17.433' AS DateTime), N'MER0001', N'638458034574334100', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4F68D6FF-5F7C-4374-BF52-684B647B75C9', N'string', NULL, CAST(N'2024-03-12T01:18:06.480' AS DateTime), N'MER0001', N'638458030864758200', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'4FAE56E1-7E4E-4AA7-8AF3-E12922BB4746', N'string', NULL, CAST(N'2024-03-11T14:19:13.740' AS DateTime), N'MER0001', N'638457635537248863', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'51177479-3A21-487C-8BF1-3A2B592E51E0', N'12345ABCDE', NULL, CAST(N'2024-03-11T23:17:27.843' AS DateTime), N'MER0001', N'638457958478337005', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'57AC4614-922B-4ADE-A3B5-95FE7E5BDCCC', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:33:48.513' AS DateTime), N'MER0001', N'638457644285090140', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'581CAFCF-818F-44B4-89ED-EFFC966642CD', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:23:28.590' AS DateTime), N'MER0001', N'638458034085940408', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'622E6988-362D-4BB7-A8BD-DDD2BEE4233D', N'12345ABCD', NULL, CAST(N'2024-03-11T22:47:00.940' AS DateTime), N'MER0001', N'638457940209321856', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'66918FFD-A7DF-45ED-8083-D0EEC44D8DBB', N'123456ABCDEF', NULL, CAST(N'2024-03-12T01:23:13.967' AS DateTime), N'MER0001', N'638458033939547651', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'685C41B0-0E6D-45EC-AD47-3778E0F45202', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:27:47.063' AS DateTime), N'MER0001', N'638458036670611842', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'7354C533-72ED-4AB4-AA59-7E1DFEFEFBC1', N'12345ABCD', NULL, CAST(N'2024-03-11T22:45:36.457' AS DateTime), N'MER0001', N'638457939364534503', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'7BF1B750-E585-4AB1-B429-7071C19F07BC', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:36:35.060' AS DateTime), N'MER0001', N'638458041950581706', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'7BFF57C1-0433-4CD2-B1C8-94025EC3654A', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:35:44.583' AS DateTime), N'MER0001', N'638457645445683266', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'7F9C802F-1052-4D7C-BEB1-F1994DFDBCBF', N'12345ABCD', NULL, CAST(N'2024-03-11T22:50:06.250' AS DateTime), N'MER0001', N'638457942062339558', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'814E5A8B-A5AA-40D4-B3FD-6C948C6E13C1', N'12345ABCD', NULL, CAST(N'2024-03-10T22:31:16.093' AS DateTime), N'MER0001', N'638457066760909297', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'8832188C-E331-4EA4-96DE-D27BE31E44E0', N'12345ABCD', NULL, CAST(N'2024-03-11T22:48:26.787' AS DateTime), N'MER0001', N'638457941067788574', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'97680654-A139-4E7A-9F28-D52EB7E8D2EC', N'12345ABCDE', NULL, CAST(N'2024-03-12T00:13:52.190' AS DateTime), N'MER0001', N'638457992321907844', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'99FF88DC-A20B-482B-9A50-93A27EF6741D', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:04.100' AS DateTime), N'MER0001', N'638457628840999403', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'9D65B67B-4B2F-4B2C-95FD-082C1D4FA80C', N'12345ABCDE', NULL, CAST(N'2024-03-11T23:10:19.780' AS DateTime), N'MER0001', N'638457954197793163', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'A16F92A3-2953-4646-994F-4DFF162929B9', N'12345ABCD', NULL, CAST(N'2024-03-11T22:46:49.933' AS DateTime), N'MER0001', N'638457940099298584', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'A41630B2-0520-4F3A-AAF0-7766E9A641E7', N'string', NULL, CAST(N'2024-03-12T01:20:20.150' AS DateTime), N'MER0001', N'638458032201404076', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'AB493344-F307-48B2-8F86-596CA9173BA1', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:32:26.187' AS DateTime), N'MER0001', N'638458039461843498', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'ADC8F7C7-AE32-42B1-B422-0C5AF6418E5B', N'12345ABCDE', NULL, CAST(N'2024-03-11T23:23:03.717' AS DateTime), N'MER0001', N'638457961837119592', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'AF115910-E7BE-4E0A-9ABC-0394CC06BF74', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:05.100' AS DateTime), N'MER0001', N'638457628850990921', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'B1347D6F-4278-40C9-8A34-EFDD19792AED', N'12345ABCDE', NULL, CAST(N'2024-03-11T15:05:58.890' AS DateTime), N'MER0001', N'638457663588850971', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'B531AFC7-33E6-45F5-9E78-1DCAF2DDE297', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:04.930' AS DateTime), N'MER0001', N'638457628849320143', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'BBB2651A-E555-4115-846E-3D8E230796F4', N'', NULL, CAST(N'2024-03-10T22:09:10.290' AS DateTime), NULL, N'', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C0AB7589-BA3F-410E-AB38-039DB6C26F45', N'string', NULL, CAST(N'2024-03-11T13:45:29.360' AS DateTime), N'MER0001', N'638457615293068779', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C0F3F1B9-220E-4479-ADBE-892D50BBE381', N'12345ABCD', NULL, CAST(N'2024-03-11T22:36:15.137' AS DateTime), N'MER0001', N'638457933751079519', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C1F23ACE-5EF1-4DE6-A7F7-9EE2D34FD643', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:35:51.167' AS DateTime), N'MER0001', N'638457645511658247', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C2653803-2B46-44DA-90A1-71F704A815E3', N'123425ABCD', NULL, CAST(N'2024-03-10T22:42:56.050' AS DateTime), N'MER0001', N'638457073760439831', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C529EF33-A4B3-4864-B856-7BD73738175F', N'12345ABCD', NULL, CAST(N'2024-03-11T22:37:09.877' AS DateTime), N'MER0001', N'638457934298634307', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'C56F10B2-835E-42BA-BF38-A5E55ECE78CA', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:05.623' AS DateTime), N'MER0001', N'638457628856247354', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'D0026BA5-6F80-4D6A-B575-78BF920D982C', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:22.217' AS DateTime), N'MER0001', N'638457629022127511', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'D2A593E3-DD72-4DF2-A795-81073BEBFC9F', N'12345ABCD', NULL, CAST(N'2024-03-11T22:47:36.643' AS DateTime), N'MER0001', N'638457940566296708', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'DA857FC8-8F6E-4BEE-B405-D6421E6679F6', N'12345ABCDE', NULL, CAST(N'2024-03-12T01:23:43.637' AS DateTime), N'MER0001', N'638458034236315912', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'DCAC70C9-72CE-45F1-BCFC-16E0434C7C91', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:03.910' AS DateTime), N'MER0001', N'638457628838998461', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'DD2DD36B-BBCA-47C8-9F44-FC43F95870A0', N'12345ABCDE', NULL, CAST(N'2024-03-11T15:00:39.377' AS DateTime), N'MER0001', N'638457660393732759', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'DF00AB54-1D6D-4BA4-B855-6A996409F0D9', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:08:05.250' AS DateTime), N'MER0001', N'638457628852530894', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'E24AC707-0416-440B-A587-E2A5EE8D26DE', N'123425ABCD', NULL, CAST(N'2024-03-10T22:47:16.933' AS DateTime), N'MER0002', N'638457076369218341', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'E956B443-D34D-47AB-B116-A9D8BE9C796E', N'12345ABCDE', NULL, CAST(N'2024-03-12T00:13:38.823' AS DateTime), N'MER0001', N'638457992188216354', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'F2C96FA8-7873-4AB9-A78A-F068C01A06F7', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:16:55.270' AS DateTime), N'MER0001', N'638457634152684013', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'F405DCC9-019F-4543-8637-F5F34430DC9C', N'12345ABCDE', NULL, CAST(N'2024-03-11T14:40:11.020' AS DateTime), N'MER0001', N'638457648110194383', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'FE209A17-5A63-456B-B3CE-4D7F74E8DB3E', N'12345ABCD', NULL, CAST(N'2024-03-10T22:35:05.883' AS DateTime), N'MER0001', N'638457069058714506', 1)
INSERT [dbo].[PaymentSignature] ([SignId], [SignValue], [SignAlgo], [SignDate], [SignOwn], [PaymentId], [IsValid]) VALUES (N'FE9421D5-6496-47FE-92D0-EF69A58A7A6E', N'12345ABCDE', NULL, CAST(N'2024-03-11T23:19:36.697' AS DateTime), N'MER0001', N'638457959766910652', 1)
GO
INSERT [HangFire].[Schema] ([Version]) VALUES (9)
GO
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'phucnd:15592:7c4427a2-eb47-40df-8b85-8c8c775d12dc', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2024-03-11T17:10:19.7555782Z"}', CAST(N'2024-03-12T03:27:36.267' AS DateTime))
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_Merchant] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchant] ([MerchantId])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_Merchant]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_PaymentDestination] FOREIGN KEY([DestId])
REFERENCES [dbo].[PaymentDestination] ([DesId])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_PaymentDestination]
GO
ALTER TABLE [dbo].[PaymentDestination]  WITH CHECK ADD  CONSTRAINT [FK_PaymentDestination_PaymentDestination] FOREIGN KEY([ParentId])
REFERENCES [dbo].[PaymentDestination] ([DesId])
GO
ALTER TABLE [dbo].[PaymentDestination] CHECK CONSTRAINT [FK_PaymentDestination_PaymentDestination]
GO
ALTER TABLE [dbo].[PaymentNotification]  WITH CHECK ADD  CONSTRAINT [FK_PaymentNotification_Merchant] FOREIGN KEY([MerchantId])
REFERENCES [dbo].[Merchant] ([MerchantId])
GO
ALTER TABLE [dbo].[PaymentNotification] CHECK CONSTRAINT [FK_PaymentNotification_Merchant]
GO
ALTER TABLE [dbo].[PaymentNotification]  WITH CHECK ADD  CONSTRAINT [FK_PaymentNotification_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
GO
ALTER TABLE [dbo].[PaymentNotification] CHECK CONSTRAINT [FK_PaymentNotification_Payment]
GO
ALTER TABLE [dbo].[PaymentSignature]  WITH CHECK ADD  CONSTRAINT [FK_PaymentSignature_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
GO
ALTER TABLE [dbo].[PaymentSignature] CHECK CONSTRAINT [FK_PaymentSignature_Payment]
GO
ALTER TABLE [dbo].[PaymentTransaction]  WITH CHECK ADD  CONSTRAINT [FK_PaymentTransaction_Payment] FOREIGN KEY([PaymentId])
REFERENCES [dbo].[Payment] ([PaymentId])
GO
ALTER TABLE [dbo].[PaymentTransaction] CHECK CONSTRAINT [FK_PaymentTransaction_Payment]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantDeleteById]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantDeleteById] 
	@MerchantId NVARCHAR(50) = '',
	@IsActive BIT = 0
AS
BEGIN
	UPDATE M 
	set		IsActive = @IsActive
	From Merchant M
	Where MerchantId = @MerchantId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantInsert]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<PhucND,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantInsert] 
	@MerchantId NVARCHAR(50) = '',
	@MerchantName NVARCHAR(250) = '',
	@MerchantWebLink NVARCHAR(250) = '',
	@MerchantIpnUrl NVARCHAR(250) = '',
	@MerchantReturnUrl NVARCHAR(250) = '',
	@SecretKey NVARCHAR(50) = '',
	@IsActive BIT = 0,
	@InsertUser NVARCHAR(50) = '',
	@InsertedId NVARCHAR(50) OUTPUT
AS
BEGIN
	if(@MerchantId is null or trim(@MerchantId) = '')
	begin
	set @MerchantId = 'MER' + SUBSTRING( master.dbo.fn_varbintohexstr(HASHBYTES('MD5', @MerchantName)),3,32)
	end

	if(@SecretKey is null or trim(@SecretKey) = '')
	begin
	set @SecretKey = NEWID()
	end
	set @InsertedId = @MerchantId

	INSERT INTO [dbo].[Merchant]
           ([MerchantId]
           ,[MerchantName]
           ,[MerchantWebLink]
           ,[MerchantIpnUrl]
           ,[MerchantReturnUrl]
           ,[SecretKey]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedAt])
     VALUES
           (@MerchantId
           ,@MerchantName
           ,@MerchantWebLink
           ,@MerchantIpnUrl
           ,@MerchantReturnUrl
           ,@SecretKey
           ,@IsActive
           ,@InsertUser
           ,GETDATE())
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectByCriteria]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectByCriteria] 
	@Criteria NVARCHAR(500) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT [MerchantId]
      ,[MerchantName]
      ,[MerchantWebLink]
      ,[MerchantIpnUrl]
      ,[MerchantReturnUrl]
      ,[SecretKey]
      ,[IsActive]
      ,[CreatedBy]
      ,[LastUpdateBy]
      ,[CreatedAt]
      ,[LastUpdateAt]
  FROM [dbo].[Merchant] (NOLOCK)
  where TRIM(@Criteria) = '' or @Criteria is null 
  or MerchantName like '%' + @Criteria + '%'
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectByCriteriaPaging]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectByCriteriaPaging] 
	@PageIndex INT = 0,
	@PageSize INT = 0,
	@Criteria NVARCHAR(500) ='',
	@TotalPage INT OUTPUT,
	@TotalCount INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    Declare @Offset int = (@PageIndex - 1) * @PageSize;
	SELECT [MerchantId]
      ,[MerchantName]
      ,[MerchantWebLink]
      ,[MerchantIpnUrl]
      ,[MerchantReturnUrl]
      ,[SecretKey]
      ,[IsActive]
      ,[CreatedBy]
      ,[LastUpdateBy]
      ,[CreatedAt]
      ,[LastUpdateAt]
  FROM [dbo].[Merchant] (NOLOCK)
  where TRIM(@Criteria) = '' or @Criteria is null 
  or MerchantName like '%' + @Criteria + '%'
  order by 
  MerchantId 
  offset @Offset rows
  fetch next @PageSize rows only

  SELECT [MerchantId]
  FROM [dbo].[Merchant] (NOLOCK)
  where TRIM(@Criteria) = '' or @Criteria is null 
  or MerchantName like '%' + @Criteria + '%'
  set @TotalCount = CEILING(@TotalCount / CONVERT(float, @PageSize))
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantSelectById]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantSelectById] 
	@MerchantId NVARCHAR(50) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT *
  FROM [dbo].[Merchant] (NOLOCK)
  where MerchantId = @MerchantId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantUpdate]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantUpdate] 
	@MerchantId NVARCHAR(50) = '',
	@MerchantName NVARCHAR(250) = '',
	@MerchantWebLink NVARCHAR(250) = '',
	@MerchantIpnUrl NVARCHAR(250) = '',
	@MerchantReturnUrl NVARCHAR(250) = '',
	@SecretKey NVARCHAR(50) = '',
	@IsActive BIT = 0,
	@UpdateUser NVARCHAR(50)
AS
BEGIN
	UPDATE M 
	set		MerchantName = @MerchantName
           ,MerchantWebLink = @MerchantWebLink
           ,MerchantIpnUrl = @MerchantIpnUrl
           ,MerchantReturnUrl =@MerchantReturnUrl
           ,SecretKey = @SecretKey
           ,IsActive = @IsActive
		   ,LastUpdateBy = @UpdateUser
		   ,LastUpdateAt = GETDATE()
	From Merchant M
	Where MerchantId = @MerchantId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_MerchantUpdateActive]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_MerchantUpdateActive] 
	@MerchantId NVARCHAR(50) = '',
	@IsActive BIT = 0,
	@UpdateUser NVARCHAR(50) = ''
AS
BEGIN
	UPDATE M 
	set		IsActive = @IsActive
		   ,LastUpdateBy = @UpdateUser
		   ,LastUpdateAt = GETDATE()
	From Merchant M
	Where MerchantId = @MerchantId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentInsert]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_PaymentInsert]
	   @Id nvarchar(50) = ''
      ,@PaymentContent nvarchar(250) = null
      ,@PaymentCurrency nvarchar(10) = null
      ,@PaymentRefId nvarchar(50) = null
      ,@RequiredAmount decimal(19,2) = null
      ,@PaymentDate datetime = null
      ,@ExpireDate datetime = null
      ,@PaymentLanguage nvarchar(10) = null
      ,@MerchantId nvarchar(50) = null
      ,@PaymentDestinationId nvarchar(50) = null
      ,@Signature nvarchar(100)= ''
      ,@InsertUser nvarchar(50) = ''
      ,@InsertedId nvarchar(50) output
AS
BEGIN
	if @PaymentDate is null
		begin
			set @PaymentDate = GETDATE()
		end

	if @ExpireDate is null
		begin
			set @ExpireDate = DATEADD(minute,15,GETDATE())
		end

	if @Id is null
		begin
			set @Id = 'PAY' + SUBSTRING(master.dbo.fn_varbintohexstr(HASHBYTES('MD5',CAST(newid() as nvarchar(50)))),3,32)
		end

	INSERT INTO [dbo].[Payment]
           ([PaymentId]
           ,[PaymentContent]
           ,[PaymentCurrency]
           ,[PaymentRefId]
           ,[RequiredAmount]
           ,[PaymentDate]
           ,[ExpireDate]
           ,[PaymentLanguage]
           ,[MerchantId]
           ,[DestId]
           ,[CreatedBy]
           ,[CreatedAt])
     VALUES
      (
	  @Id 
      ,@PaymentContent 
      ,@PaymentCurrency 
      ,@PaymentRefId 
      ,@RequiredAmount 
      ,@PaymentDate 
      ,@ExpireDate 
      ,@PaymentLanguage 
      ,@MerchantId 
      ,@PaymentDestinationId 
      ,@InsertUser 
      ,getdate())
	  set @InsertedId = @Id

	  INSERT INTO [dbo].[PaymentSignature]
           ([SignId]
           ,[SignValue]
           ,[SignDate]
           ,[SignOwn]
           ,[PaymentId]
           ,[IsValid])
     VALUES
           (newid()
           ,@Signature
           ,getdate()
           ,@MerchantId
           ,@Id
           ,1)
END

GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentSelectById]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_PaymentSelectById]
	@PaymentId nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
  FROM [dbo].[Payment](nolock)
  where [PaymentId] = @PaymentId
END
GO
/****** Object:  StoredProcedure [dbo].[sproc_PaymentTransactionInsert]    Script Date: 3/12/2024 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sproc_PaymentTransactionInsert]
@Id nvarchar(50) = '',
@TranMessage nvarchar(250) = '',
@TranPayLoad nvarchar(500) = '',
@TranStatus nvarchar(10) = '',
@TransAmount decimal(19,2) null, 
@TransDate datetime null,
@PaymentId  nvarchar(50) = '',
@InsertUser  nvarchar(50) =''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if @TransDate is null
	begin
		set @TransDate = getdate()
	end
	begin transaction CreatePaymentTransaction
		begin try
			INSERT INTO [dbo].[PaymentTransaction]
           ([TransId]
           ,[TransMessage]
           ,[TransPayload]
           ,[TransStatus]
           ,[TransAmount]
           ,[TransDate]
           ,[PaymentId]
		   ,[CreatedBy]
		   ,[CreatedAt])
     VALUES
           (@Id
           ,@TranMessage
           ,@TranPayLoad
           ,@TranStatus
           ,@TransAmount
           ,@TransDate
           ,@PaymentId
		   ,@InsertUser
		   ,Getdate())

		   update p
				set 
					p.PaidAmount = t.PaidAmount,
					p.PaymentLastMessage = @TranMessage,
					p.PaymentStatus = @TranStatus,
					p.LastUpdatedAt = getdate(),
					p.LastUpdatedBy = @InsertUser
				from Payment p
				join(
						select PaymentId, sum(TransAmount) As PaidAmount
					from PaymentTransaction
					where PaymentId = @PaymentId and TransStatus = '0'
					group by PaymentId
					) t on p.PaymentId = t.PaymentId

					commit transaction CreatePaymentTransaction 
					end try
					begin catch
			rollback transaction CreatePaymentTransaction 
		end catch
END
GO
