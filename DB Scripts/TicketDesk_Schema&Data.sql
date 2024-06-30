USE [master]
GO
/****** Object:  Database [TicketDesk]    Script Date: 01-07-2024 02:15:01 ******/
CREATE DATABASE [TicketDesk]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TicketDesk', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TicketDesk.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TicketDesk_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TicketDesk_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TicketDesk] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TicketDesk].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TicketDesk] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TicketDesk] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TicketDesk] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TicketDesk] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TicketDesk] SET ARITHABORT OFF 
GO
ALTER DATABASE [TicketDesk] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TicketDesk] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TicketDesk] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TicketDesk] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TicketDesk] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TicketDesk] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TicketDesk] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TicketDesk] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TicketDesk] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TicketDesk] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TicketDesk] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TicketDesk] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TicketDesk] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TicketDesk] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TicketDesk] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TicketDesk] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TicketDesk] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TicketDesk] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TicketDesk] SET  MULTI_USER 
GO
ALTER DATABASE [TicketDesk] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TicketDesk] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TicketDesk] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TicketDesk] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TicketDesk] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TicketDesk] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TicketDesk] SET QUERY_STORE = ON
GO
ALTER DATABASE [TicketDesk] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TicketDesk]
GO
/****** Object:  User [Q-LT-2024-025\Akash.Madhu]    Script Date: 01-07-2024 02:15:01 ******/
CREATE USER [Q-LT-2024-025\Akash.Madhu] FOR LOGIN [Q-LT-2024-025\Akash.Madhu] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Q-LT-2024-025\Akash.Madhu]
GO
/****** Object:  Schema [TicketDesk.dbo]    Script Date: 01-07-2024 02:15:01 ******/
CREATE SCHEMA [TicketDesk.dbo]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[AgentId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AgentTicketMapping]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AgentTicketMapping](
	[MappingId] [uniqueidentifier] NOT NULL,
	[AgentId] [uniqueidentifier] NOT NULL,
	[TicketId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_AgentTicketMapping] PRIMARY KEY CLUSTERED 
(
	[MappingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ApplicationLogs]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLogs](
	[LogId] [uniqueidentifier] NOT NULL,
	[ErrorDiscription] [nvarchar](max) NULL,
	[SatckTrace] [nvarchar](max) NULL,
	[TraceDiscription] [nvarchar](150) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ApplicationLogs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
	[ISOAlpha2Code] [nvarchar](50) NOT NULL,
	[ISOAlpha3Code] [nvarchar](50) NOT NULL,
	[ISONumericCode] [int] NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_Applications] PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genders]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genders](
	[GenderId] [int] IDENTITY(1,1) NOT NULL,
	[GenderName] [nvarchar](10) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_Genders] PRIMARY KEY CLUSTERED 
(
	[GenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoginLogs]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginLogs](
	[LginLogId] [uniqueidentifier] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_LoginLogs] PRIMARY KEY CLUSTERED 
(
	[LginLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[TicketId] [uniqueidentifier] NOT NULL,
	[TicketTypeId] [int] NULL,
	[DepartmentId] [int] NULL,
	[TicketTitle] [nvarchar](150) NOT NULL,
	[TicketDescription] [nvarchar](max) NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Tickets] PRIMARY KEY CLUSTERED 
(
	[TicketId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TicketTypes]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TicketTypes](
	[TicketTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TicketTypeName] [nvarchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_TicketTypes] PRIMARY KEY CLUSTERED 
(
	[TicketTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserProfile]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserProfile](
	[ProfileId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[DisplayName] [nvarchar](20) NULL,
	[GenderId] [int] NULL,
	[CountryId] [int] NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_UserProfile] PRIMARY KEY CLUSTERED 
(
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[PhoneNumber] [bigint] NOT NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](25) NOT NULL,
	[RoleId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'852bcb5f-7fe0-4c1a-a033-127cc6b03e57', N'4444d748-6f64-4b2b-b031-ead6c0565265', CAST(N'2024-06-30T15:28:41.867' AS DateTime), N'4444d748-6f64-4b2b-b031-ead6c0565265', NULL, CAST(N'2024-06-30T15:28:41.867' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'132eda15-ad9b-4946-b631-1ed1bf514217', N'50b70d79-80c2-4869-a2fe-cab40c9d2efe', CAST(N'2024-07-01T01:59:59.093' AS DateTime), N'50b70d79-80c2-4869-a2fe-cab40c9d2efe', NULL, CAST(N'2024-07-01T01:59:59.093' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'525e5c9c-c909-4cf8-8803-1f280be72a24', N'd90f0047-acc9-4e21-a71a-175209b00182', CAST(N'2024-07-01T01:59:13.777' AS DateTime), N'd90f0047-acc9-4e21-a71a-175209b00182', NULL, CAST(N'2024-07-01T01:59:13.777' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'02cd5cb8-4d7f-4454-ab37-35e809bca464', N'e6307285-b925-40a0-9cc9-ba10f417c7af', CAST(N'2024-07-01T01:57:52.503' AS DateTime), N'e6307285-b925-40a0-9cc9-ba10f417c7af', NULL, CAST(N'2024-07-01T01:57:52.503' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'2b851468-3706-4ca5-8b60-40fb1c4948de', N'40a2b18e-be01-491e-a1c5-14984c8e71ea', CAST(N'2024-06-23T23:47:04.737' AS DateTime), N'40a2b18e-be01-491e-a1c5-14984c8e71ea', NULL, CAST(N'2024-06-23T23:47:04.737' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'74ee8334-aece-4316-9533-5a26911e786e', N'4c40691b-4d7b-4b98-9dd3-0baaca0822c0', CAST(N'2024-06-30T17:37:49.890' AS DateTime), N'4c40691b-4d7b-4b98-9dd3-0baaca0822c0', NULL, CAST(N'2024-06-30T17:37:49.890' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'a2190766-9205-43d4-bcff-5fdb002d03fe', N'b68f17a1-9988-476a-a8ba-20834cc1d41b', CAST(N'2024-06-30T15:18:32.560' AS DateTime), N'b68f17a1-9988-476a-a8ba-20834cc1d41b', NULL, CAST(N'2024-06-30T15:18:32.560' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'32b5f769-027e-47f8-a1c4-65d352ca92ad', N'd5bfbdf1-662b-46df-9520-d0c01be682be', CAST(N'2024-06-29T22:43:03.287' AS DateTime), N'd5bfbdf1-662b-46df-9520-d0c01be682be', NULL, CAST(N'2024-06-29T22:43:03.287' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'7be05078-8f33-44f4-9528-70b42badb8ef', N'8a17ff0f-1536-4dd5-ae7a-eaa7f4801b31', CAST(N'2024-06-30T17:56:50.863' AS DateTime), N'8a17ff0f-1536-4dd5-ae7a-eaa7f4801b31', NULL, CAST(N'2024-06-30T17:56:50.863' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'1cc898b8-07f0-49c7-b812-74132788a9c6', N'b75bdfaa-b48a-43f6-86ee-dc39f7f99160', CAST(N'2024-06-30T15:25:00.990' AS DateTime), N'b75bdfaa-b48a-43f6-86ee-dc39f7f99160', NULL, CAST(N'2024-06-30T15:25:00.990' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'8ef4f1db-4a42-4818-afec-7cd348d30068', N'1b24700c-0274-42cd-b3f9-39505942aa37', CAST(N'2024-06-23T23:33:35.497' AS DateTime), N'1b24700c-0274-42cd-b3f9-39505942aa37', NULL, CAST(N'2024-06-23T23:33:35.497' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'ff99e5e0-d405-4643-bfe3-8f73cf2a3045', N'08e6f820-af22-435b-9766-acb1862745c5', CAST(N'2024-06-30T11:26:12.833' AS DateTime), N'08e6f820-af22-435b-9766-acb1862745c5', NULL, CAST(N'2024-06-30T11:26:12.833' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'3c253d16-8d50-4a8c-8bbf-95ebe97d02aa', N'db7750ef-0607-4246-a22f-5d645301965f', CAST(N'2024-06-30T12:07:46.587' AS DateTime), N'db7750ef-0607-4246-a22f-5d645301965f', NULL, CAST(N'2024-06-30T12:07:46.587' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'af468fe8-8ef0-4f03-85ee-abc6588a2acd', N'a7b8345a-187b-4638-90da-8b3ea0cb0f8b', CAST(N'2024-07-01T00:44:27.510' AS DateTime), N'a7b8345a-187b-4638-90da-8b3ea0cb0f8b', NULL, CAST(N'2024-07-01T00:44:27.510' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'173e51ff-3694-4697-85f7-b436a4cc9f14', N'2ee3fe35-2a0f-4180-a1e0-18fb290363f8', CAST(N'2024-06-23T23:32:06.560' AS DateTime), N'2ee3fe35-2a0f-4180-a1e0-18fb290363f8', NULL, CAST(N'2024-06-23T23:32:06.560' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'37bdd30f-8421-4792-aff2-c060bde1adea', N'4d1494ea-8a1e-436c-aa73-a52b57e28113', CAST(N'2024-06-23T18:56:11.683' AS DateTime), N'4d1494ea-8a1e-436c-aa73-a52b57e28113', NULL, CAST(N'2024-06-23T18:56:11.683' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'870b5154-c486-4f23-8f28-d04a2646a53e', N'8b463d89-8c3a-4862-b755-b7963f9c10c5', CAST(N'2024-06-30T17:49:26.147' AS DateTime), N'8b463d89-8c3a-4862-b755-b7963f9c10c5', NULL, CAST(N'2024-06-30T17:49:26.147' AS DateTime))
INSERT [dbo].[Agents] ([AgentId], [UserId], [CreatedOn], [CreatedBy], [ModifiedBy], [ModifiedOn]) VALUES (N'04cb499f-1d76-4458-99a0-e7c32cb9632a', N'd9a200c8-8f76-4f49-a561-4c098ea063f7', CAST(N'2024-06-29T21:25:38.307' AS DateTime), N'd9a200c8-8f76-4f49-a561-4c098ea063f7', NULL, CAST(N'2024-06-29T21:25:38.307' AS DateTime))
GO
INSERT [dbo].[AgentTicketMapping] ([MappingId], [AgentId], [TicketId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'601a7679-c38c-43e8-b6d6-4101f2dbed13', N'7be05078-8f33-44f4-9528-70b42badb8ef', N'3eb97840-a63b-40ab-b1f6-13229b822c47', CAST(N'2024-07-01T02:01:19.220' AS DateTime), N'7fe92677-f923-4e29-8fc2-ecc03062dfee', NULL, NULL)
INSERT [dbo].[AgentTicketMapping] ([MappingId], [AgentId], [TicketId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'347ce362-601f-4c4f-936c-546819973ff8', N'7be05078-8f33-44f4-9528-70b42badb8ef', N'13946757-a4d3-440c-8844-2ff21d2df79e', CAST(N'2024-07-01T02:05:19.583' AS DateTime), N'7fe92677-f923-4e29-8fc2-ecc03062dfee', NULL, NULL)
INSERT [dbo].[AgentTicketMapping] ([MappingId], [AgentId], [TicketId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'c053a3d2-3368-4236-abe8-7f368f0909bc', N'af468fe8-8ef0-4f03-85ee-abc6588a2acd', N'489c190d-6199-417d-ac31-117be2967d93', CAST(N'2024-07-01T01:08:43.643' AS DateTime), N'7fe92677-f923-4e29-8fc2-ecc03062dfee', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Countries] ON 

INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (1, N'United States', N'US', N'USA', 840)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (2, N'Canada', N'CA', N'CAN', 124)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (3, N'United Kingdom', N'GB', N'GBR', 826)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (4, N'Australia', N'AU', N'AUS', 36)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (5, N'Germany', N'DE', N'DEU', 276)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (6, N'France', N'FR', N'FRA', 250)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (7, N'India', N'IN', N'IND', 356)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (8, N'China', N'CN', N'CHN', 156)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (9, N'Japan', N'JP', N'JPN', 392)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOAlpha2Code], [ISOAlpha3Code], [ISONumericCode]) VALUES (10, N'Brazil', N'BR', N'BRA', 76)
SET IDENTITY_INSERT [dbo].[Countries] OFF
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (5, N'Sales', CAST(N'2024-06-22T16:41:13.740' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (6, N'Support', CAST(N'2024-06-22T16:41:13.740' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (7, N'Billing', CAST(N'2024-06-22T16:41:13.740' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (8, N'Human Resources', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (9, N'IT', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (10, N'Customer Service', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (11, N'Operations', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (12, N'Marketing', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (13, N'Legal', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (14, N'Finance', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
INSERT [dbo].[Departments] ([DepartmentId], [DepartmentName], [CreatedOn]) VALUES (15, N'Procurement', CAST(N'2024-06-22T16:41:13.743' AS DateTime))
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Genders] ON 

INSERT [dbo].[Genders] ([GenderId], [GenderName], [CreatedOn]) VALUES (1, N'Male', CAST(N'2024-06-22T15:13:29.420' AS DateTime))
INSERT [dbo].[Genders] ([GenderId], [GenderName], [CreatedOn]) VALUES (2, N'Female', CAST(N'2024-06-22T15:13:29.420' AS DateTime))
INSERT [dbo].[Genders] ([GenderId], [GenderName], [CreatedOn]) VALUES (3, N'Other', CAST(N'2024-06-22T15:13:29.423' AS DateTime))
SET IDENTITY_INSERT [dbo].[Genders] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [CreatedOn]) VALUES (1, N'Super Admin', CAST(N'2024-06-22T14:34:42.100' AS DateTime))
INSERT [dbo].[Roles] ([RoleId], [RoleName], [CreatedOn]) VALUES (2, N'Admin', CAST(N'2024-06-22T14:34:42.103' AS DateTime))
INSERT [dbo].[Roles] ([RoleId], [RoleName], [CreatedOn]) VALUES (3, N'Agent', CAST(N'2024-06-22T14:34:42.103' AS DateTime))
INSERT [dbo].[Roles] ([RoleId], [RoleName], [CreatedOn]) VALUES (4, N'Customer', CAST(N'2024-06-22T14:34:42.103' AS DateTime))
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusId], [StatusName], [CreatedOn]) VALUES (1, N'Open', CAST(N'2024-06-22T15:12:27.813' AS DateTime))
INSERT [dbo].[Status] ([StatusId], [StatusName], [CreatedOn]) VALUES (2, N'InProgress', CAST(N'2024-06-22T15:12:27.840' AS DateTime))
INSERT [dbo].[Status] ([StatusId], [StatusName], [CreatedOn]) VALUES (3, N'Resolved', CAST(N'2024-06-22T15:12:27.840' AS DateTime))
INSERT [dbo].[Status] ([StatusId], [StatusName], [CreatedOn]) VALUES (4, N'Closed', CAST(N'2024-06-22T15:12:27.840' AS DateTime))
INSERT [dbo].[Status] ([StatusId], [StatusName], [CreatedOn]) VALUES (5, N'InActive', CAST(N'2024-06-22T16:59:00.213' AS DateTime))
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'489c190d-6199-417d-ac31-117be2967d93', NULL, NULL, N'Test Ticket', N'adlajklas', 4, CAST(N'2024-06-30T14:44:23.180' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-07-01T01:37:06.147' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'3eb97840-a63b-40ab-b1f6-13229b822c47', NULL, NULL, N'Testing Ticket Creation 2', N'Testing Ticket Creation 2', 4, CAST(N'2024-06-30T17:55:36.750' AS DateTime), N'316b73fc-a7ce-459e-a1ed-7bcb9614f275', CAST(N'2024-07-01T02:06:04.010' AS DateTime), N'316b73fc-a7ce-459e-a1ed-7bcb9614f275')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'a9c1c00d-7f8a-48dc-abcd-183f8445769a', 2, 9, N'Ticket Creation', N'I''m not able to create a Ticket', 3, CAST(N'2024-06-23T21:39:03.110' AS DateTime), N'4d1494ea-8a1e-436c-aa73-a52b57e28113', CAST(N'2024-06-23T21:39:03.110' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'4c21c0ee-22b2-490b-ace3-1cfe69217f90', NULL, NULL, N'Test Ticket 4', N'Testing ticket', 5, CAST(N'2024-06-30T14:43:08.613' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-06-30T14:43:08.613' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'79c3754e-f51c-4d6f-aea7-1fa02ac26fab', NULL, NULL, N'Test', N'Ticket', 5, CAST(N'2024-06-30T16:15:41.037' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:15:41.037' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'692f59fb-93fc-4448-926b-2ed5157187ac', 2, 9, N'ticket Title', N'Ticket Description', 2, CAST(N'2024-06-22T16:41:54.073' AS DateTime), N'7fe92677-f923-4e29-8fc2-ecc03062dfee', CAST(N'2024-06-30T14:08:01.847' AS DateTime), N'db7750ef-0607-4246-a22f-5d645301965f')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'13946757-a4d3-440c-8844-2ff21d2df79e', NULL, NULL, N'Road Blocks', N'Program creation not happening in RAM', 4, CAST(N'2024-06-29T18:31:58.770' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', CAST(N'2024-07-01T02:09:34.730' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'a3789e7a-cffd-4bd3-8fc0-4873073fa2c6', NULL, NULL, N'kldalsjksd', N'qlwkdklajd', 5, CAST(N'2024-06-30T16:11:07.293' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:11:07.293' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'b7c7d8d1-9fe9-4856-a21b-4aa926882e79', NULL, NULL, N'Ticket Title 2 ', N'Ticket Description 2', 5, CAST(N'2024-06-30T15:35:30.277' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052', CAST(N'2024-06-30T15:35:40.573' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'726b69a7-1bad-4af3-bf1c-4ae6b36658f4', NULL, NULL, N'Test Ticket', N'Testing ticketqa', 5, CAST(N'2024-06-30T15:17:01.523' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:07:12.507' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'2ea94e2f-847e-462d-b2fd-5ddb8252acd3', 2, 9, N'Ticket Title testing', N'Testing ticket description', 2, CAST(N'2024-06-23T21:33:53.830' AS DateTime), N'4d1494ea-8a1e-436c-aa73-a52b57e28113', CAST(N'2024-06-23T21:33:53.830' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'395c0d01-bf8e-4aa4-b7fe-5ded2ccc364c', NULL, NULL, N'Testing Ticket', N'Testing Ticket creation', 1, CAST(N'2024-06-30T17:47:45.650' AS DateTime), N'53f5ddc1-b035-45e2-9c24-56556605a647', CAST(N'2024-06-30T17:47:53.113' AS DateTime), N'53f5ddc1-b035-45e2-9c24-56556605a647')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'd8ce26c5-d04d-451e-b911-6a9e77471113', NULL, NULL, N'Customer Ticket testing', N'Customer Ticket testing', 5, CAST(N'2024-07-01T01:55:42.120' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10', CAST(N'2024-07-01T01:55:58.510' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'beae0b28-84d0-4ec8-8bfe-6c32f0414e30', NULL, NULL, N'Test Ticket', N'qwdawsdas', 5, CAST(N'2024-06-30T16:06:36.057' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:06:36.057' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'9bc4fa2d-29bd-433d-aa77-6c8b15d1d862', NULL, NULL, N'Testing Ticket Creating', N'Testing Ticket Creation', 1, CAST(N'2024-06-30T17:55:16.960' AS DateTime), N'316b73fc-a7ce-459e-a1ed-7bcb9614f275', CAST(N'2024-06-30T17:55:16.960' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'5480db22-c68d-47a1-b9e0-6e80b0f1d9ae', NULL, NULL, N'Test', N'Ticket', 5, CAST(N'2024-06-30T16:08:52.950' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:08:52.950' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'703d3ed2-83a7-4315-8877-75b30cad8df2', NULL, NULL, N'edajkldka', N'ledlajdleqweqweqw', 5, CAST(N'2024-06-29T18:32:42.140' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', CAST(N'2024-06-29T18:33:02.987' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'47574259-f786-4785-869e-7b8ba8af1337', NULL, NULL, N'Customer Ticket testing V2', N'Customer Ticket testing V2', 1, CAST(N'2024-07-01T01:56:14.363' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10', CAST(N'2024-07-01T01:56:49.423' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'4eee99f0-da0a-4428-9f2a-7ba5496eb5dc', NULL, NULL, N'test Ticket 2', N'Test Ticket 2', 5, CAST(N'2024-06-30T15:17:29.983' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T15:17:29.983' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'7840086a-b13a-44ff-b4a4-80b17ae69f77', NULL, NULL, N'Ticket Title', N'Ticket Description', 4, CAST(N'2024-06-30T15:35:09.553' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052', CAST(N'2024-06-30T15:38:20.740' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'e6a0497f-b664-4e0d-9f37-89b362467e0e', NULL, NULL, N'Test Ticket 2', N'Test Ticket 2', 5, CAST(N'2024-06-30T14:26:40.450' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-06-30T14:26:50.983' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'd77922fa-7a04-4a6c-b728-8a752bc18776', NULL, NULL, N'Testing Ticket ', N'Testing Ticket Creation', 4, CAST(N'2024-06-30T17:36:26.807' AS DateTime), N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff', CAST(N'2024-06-30T17:41:02.757' AS DateTime), N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'8a437e8e-3fe3-419c-a253-8af5f0e1b95e', NULL, NULL, N'eqweqwwddasddc', N'qweqwesada12', 4, CAST(N'2024-06-29T18:35:26.367' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', CAST(N'2024-06-30T14:08:40.690' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'810eae0c-a8a7-4f14-910b-9cd08cf77eab', NULL, NULL, N'Test Ticket', N'kljeldalsdj', 5, CAST(N'2024-06-30T16:07:55.570' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:07:55.570' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'bf3169a4-f3f2-4bbb-b325-a5f09b5d70fa', NULL, NULL, N'fvfvdfdf', N'vdfdfvdfuidfas89', 5, CAST(N'2024-06-29T16:23:06.420' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', CAST(N'2024-06-29T18:27:26.077' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'0ea2c269-08dc-4818-b9c7-b0122d63bc4b', NULL, NULL, N'Testing ticket', N'testing ticket creation version 2', 5, CAST(N'2024-06-30T17:48:15.480' AS DateTime), N'53f5ddc1-b035-45e2-9c24-56556605a647', CAST(N'2024-06-30T17:48:15.480' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'8ce7c5a7-768d-4c0b-bc7b-d22f166d293d', NULL, NULL, N'Test Ticket', N'Test Ticket', 5, CAST(N'2024-06-30T14:43:33.307' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-06-30T14:43:33.307' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'1969fd0d-1359-4628-94a9-d9572be80cb9', NULL, NULL, N'Customer Ticket testing', N'Customer Ticket testing', 1, CAST(N'2024-07-01T01:56:35.333' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10', CAST(N'2024-07-01T01:56:35.333' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'de24c121-dce4-4047-a828-e19e8ae26ab5', NULL, NULL, N'Test Ticket 1', N'Test Ticket 1', 1, CAST(N'2024-06-30T14:26:01.880' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-06-30T14:26:59.300' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca')
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'3061e71a-94a8-45ed-87ba-e5672718d350', NULL, NULL, N'addasndans', N'jaskdkasd', 1, CAST(N'2024-06-30T16:11:27.230' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T16:11:27.230' AS DateTime), NULL)
INSERT [dbo].[Tickets] ([TicketId], [TicketTypeId], [DepartmentId], [TicketTitle], [TicketDescription], [StatusId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'961dd2e2-025c-4ca7-9aba-ee63cb05e5d8', NULL, NULL, N'testing Ticket 2', N'testing Ticket creation part 2', 5, CAST(N'2024-06-30T17:36:50.450' AS DateTime), N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff', CAST(N'2024-06-30T17:36:50.450' AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[TicketTypes] ON 

INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (1, N'Question', CAST(N'2024-06-22T16:06:08.503' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (2, N'Incident', CAST(N'2024-06-22T16:06:08.530' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (3, N'Problem', CAST(N'2024-06-22T16:06:08.530' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (4, N'Feature Request', CAST(N'2024-06-22T16:06:08.530' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (5, N'Task', CAST(N'2024-06-22T16:06:08.530' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (6, N'Service Request', CAST(N'2024-06-22T16:06:08.533' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (7, N'Complaint', CAST(N'2024-06-22T16:06:08.533' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (8, N'Bug', CAST(N'2024-06-22T16:06:08.533' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (9, N'Lead', CAST(N'2024-06-22T16:06:08.533' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (10, N'Sales', CAST(N'2024-06-22T16:08:15.440' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (11, N'Support', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (12, N'Billing', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (13, N'HR', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (14, N'IT', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (15, N'Customer Service', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (16, N'Operations', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (17, N'Marketing', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
INSERT [dbo].[TicketTypes] ([TicketTypeId], [TicketTypeName], [CreatedOn]) VALUES (18, N'Legal', CAST(N'2024-06-22T16:08:15.470' AS DateTime))
SET IDENTITY_INSERT [dbo].[TicketTypes] OFF
GO
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'69809405-d0e5-4ca6-b5ad-0dd8e592a33a', N'8b463d89-8c3a-4862-b755-b7963f9c10c5', NULL, NULL, NULL, CAST(N'2024-06-30T17:49:26.147' AS DateTime), NULL, CAST(N'2024-06-30T17:49:26.147' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'ccc04e0d-8a2b-476f-aa07-1b34b60de2bb', N'7d92bf3a-0215-4d05-85e5-41d0b4b39052', N'Customer', 1, 7, CAST(N'2024-06-30T15:34:09.437' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052', CAST(N'2024-06-30T15:34:46.510' AS DateTime), N'7d92bf3a-0215-4d05-85e5-41d0b4b39052')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'4a63ccc3-63b5-4645-b2ad-2fc626c633c4', N'b75bdfaa-b48a-43f6-86ee-dc39f7f99160', NULL, NULL, NULL, CAST(N'2024-06-30T15:25:00.990' AS DateTime), NULL, CAST(N'2024-06-30T15:25:00.990' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'fb4d9658-6ad8-4b19-bff4-42158ed243c9', N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', N'Customer', 1, 7, CAST(N'2024-06-30T15:16:15.150' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', CAST(N'2024-06-30T15:16:37.520' AS DateTime), N'eb378d88-8d54-4c4b-ac4d-21045037a0c9')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'77be861a-bb79-42d4-82b6-4ea886d15dd7', N'650ef4dd-caf8-4aec-ad32-5e0100ede979', NULL, NULL, NULL, CAST(N'2024-06-30T14:29:26.853' AS DateTime), N'650ef4dd-caf8-4aec-ad32-5e0100ede979', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'8abdb6e1-c0ca-4ba5-9ea0-5081fa9991cb', N'7fe92677-f923-4e29-8fc2-ecc03062dfee', N'Akash', 1, 7, CAST(N'2024-06-22T15:21:06.473' AS DateTime), N'7fe92677-f923-4e29-8fc2-ecc03062dfee', CAST(N'2024-06-22T15:21:06.473' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'd04cbd54-d821-47f4-9b58-522e4a7d3872', N'60fe1af8-403a-4510-9293-8b080e69fc16', NULL, NULL, NULL, CAST(N'2024-06-28T01:07:40.373' AS DateTime), N'60fe1af8-403a-4510-9293-8b080e69fc16', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'411827bb-814d-48e5-990c-53d4b0abda2f', N'486b2c08-4816-4c8c-8d67-0adb43897e10', NULL, NULL, NULL, CAST(N'2024-07-01T01:49:26.190' AS DateTime), N'486b2c08-4816-4c8c-8d67-0adb43897e10', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'a23a56b8-6392-48aa-8743-6d92eda0002a', N'a7b8345a-187b-4638-90da-8b3ea0cb0f8b', N'Allan', 1, 7, CAST(N'2024-07-01T00:44:27.510' AS DateTime), NULL, CAST(N'2024-07-01T01:31:31.133' AS DateTime), N'a7b8345a-187b-4638-90da-8b3ea0cb0f8b')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'4ff3b6b0-1402-4ee9-ad12-70213bbf08eb', N'50b70d79-80c2-4869-a2fe-cab40c9d2efe', NULL, NULL, NULL, CAST(N'2024-07-01T01:59:59.093' AS DateTime), NULL, CAST(N'2024-07-01T01:59:59.093' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'ad9e2399-08c1-4199-86e9-7a581d8d44a4', N'b68f17a1-9988-476a-a8ba-20834cc1d41b', NULL, NULL, NULL, CAST(N'2024-06-30T15:18:32.560' AS DateTime), NULL, CAST(N'2024-06-30T15:18:32.560' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'10dc2829-09eb-44e3-8253-81d552f3dec1', N'53f5ddc1-b035-45e2-9c24-56556605a647', N'TestingCustomer', 1, 7, CAST(N'2024-06-30T17:46:58.763' AS DateTime), N'53f5ddc1-b035-45e2-9c24-56556605a647', CAST(N'2024-06-30T17:47:23.380' AS DateTime), N'53f5ddc1-b035-45e2-9c24-56556605a647')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'9e65abc4-7c46-41d5-b52e-87a5e988eb96', N'f5aa384f-77fa-4368-a0cf-8646f804bdca', N'Customer', 1, 7, CAST(N'2024-06-30T14:25:17.890' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca', CAST(N'2024-06-30T14:25:44.180' AS DateTime), N'f5aa384f-77fa-4368-a0cf-8646f804bdca')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'fe292703-0e41-47b4-b557-8fbe9b62dec8', N'4c40691b-4d7b-4b98-9dd3-0baaca0822c0', N'AgentTest', 1, 4, CAST(N'2024-06-30T17:37:49.887' AS DateTime), NULL, CAST(N'2024-06-30T17:38:36.640' AS DateTime), N'4c40691b-4d7b-4b98-9dd3-0baaca0822c0')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'771b8454-b716-4514-9089-91844959923b', N'4e14a275-20ac-44f7-94d9-7e04e4e76e3d', NULL, NULL, NULL, CAST(N'2024-06-28T01:23:02.703' AS DateTime), N'4e14a275-20ac-44f7-94d9-7e04e4e76e3d', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'3b6da69b-a081-4e5f-875c-93cd95d216f6', N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff', N'TestingCustomer', 1, 7, CAST(N'2024-06-30T17:35:31.570' AS DateTime), N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff', CAST(N'2024-06-30T17:36:02.007' AS DateTime), N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'8935d795-e124-4e1e-a7cd-9dc27ab616ad', N'db7750ef-0607-4246-a22f-5d645301965f', N'Dumpling', 1, 7, CAST(N'2024-06-30T12:07:46.587' AS DateTime), NULL, CAST(N'2024-06-30T12:21:35.103' AS DateTime), N'db7750ef-0607-4246-a22f-5d645301965f')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'12fc14ce-02fe-4904-8b8a-a538541ee000', N'e6307285-b925-40a0-9cc9-ba10f417c7af', NULL, NULL, NULL, CAST(N'2024-07-01T01:57:52.503' AS DateTime), NULL, CAST(N'2024-07-01T01:57:52.503' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'808e2839-62be-4c5c-8277-d2572824d2db', N'33630d12-65bd-4b60-ae54-15bdc83bf753', N'Digan', 1, 7, CAST(N'2024-06-30T15:32:25.370' AS DateTime), N'33630d12-65bd-4b60-ae54-15bdc83bf753', CAST(N'2024-06-30T15:53:23.570' AS DateTime), N'33630d12-65bd-4b60-ae54-15bdc83bf753')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'0e197b97-aec8-49c0-a6cb-d5f0fdbb4ac0', N'8a17ff0f-1536-4dd5-ae7a-eaa7f4801b31', N'Aent', 1, 8, CAST(N'2024-06-30T17:56:50.863' AS DateTime), NULL, CAST(N'2024-06-30T17:58:22.410' AS DateTime), N'8a17ff0f-1536-4dd5-ae7a-eaa7f4801b31')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'494be58f-51b8-468f-b34a-df650cf5f235', N'316b73fc-a7ce-459e-a1ed-7bcb9614f275', N'Akash', 1, 7, CAST(N'2024-06-30T17:54:22.500' AS DateTime), N'316b73fc-a7ce-459e-a1ed-7bcb9614f275', CAST(N'2024-06-30T17:54:52.857' AS DateTime), N'316b73fc-a7ce-459e-a1ed-7bcb9614f275')
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'c8da7685-e6c1-41c0-93d9-e6056462e931', N'4444d748-6f64-4b2b-b031-ead6c0565265', NULL, NULL, NULL, CAST(N'2024-06-30T15:28:41.867' AS DateTime), NULL, CAST(N'2024-06-30T15:28:41.867' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'd3d0728b-fa66-4c1b-9b0d-e67f40013bff', N'd074eb33-1399-473c-b949-7b85f6686bc0', NULL, NULL, NULL, CAST(N'2024-06-28T06:29:57.960' AS DateTime), N'd074eb33-1399-473c-b949-7b85f6686bc0', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'13ea35ad-ba1c-4699-a5d0-ec9f3036e4ab', N'd90f0047-acc9-4e21-a71a-175209b00182', NULL, NULL, NULL, CAST(N'2024-07-01T01:59:13.777' AS DateTime), NULL, CAST(N'2024-07-01T01:59:13.777' AS DateTime), NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'84110fb5-68fd-4051-94cc-ef0b737cff52', N'deb9f2b1-757f-43df-bd7e-1d9f4bbf228e', NULL, NULL, NULL, CAST(N'2024-06-28T01:15:31.013' AS DateTime), N'deb9f2b1-757f-43df-bd7e-1d9f4bbf228e', NULL, NULL)
INSERT [dbo].[UserProfile] ([ProfileId], [UserId], [DisplayName], [GenderId], [CountryId], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (N'089ad34b-5721-4004-aea7-f98df3bc822e', N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', N'Digan', 1, 5, CAST(N'2024-06-28T06:35:22.050' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', CAST(N'2024-06-28T13:12:16.540' AS DateTime), N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70')
GO
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'486b2c08-4816-4c8c-8d67-0adb43897e10', N'Customer', N'TicketDesk', 8888888888, N'customerticketdesk@ticketdesk.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-07-01T01:49:26.187' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'4c40691b-4d7b-4b98-9dd3-0baaca0822c0', N'CreatingAgent', N'Testing', 0, N'testingagentcrea@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T17:37:49.883' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'ceb56b3c-e7d1-44de-83e4-0bdcc2c2ba70', N'Dinu', N'Johnson', 0, N'dinu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-28T06:35:22.047' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'368c7226-6535-49ec-becc-0d9544efa5d8', N'Agent', N'57', 5757575757, N'akash57@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T23:48:59.473' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'40a2b18e-be01-491e-a1c5-14984c8e71ea', N'Agent', N'AK47', 8075318645, N'akashmadhu864@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T23:47:04.737' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'33630d12-65bd-4b60-ae54-15bdc83bf753', N'Custmer', N'TicketDesk', 0, N'ticketdeskcustomer@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T15:32:25.367' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'd90f0047-acc9-4e21-a71a-175209b00182', N'Agent', N'TicketDesk', 7777666666, N'akashmadhu77766666777@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-07-01T01:59:13.777' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'2ee3fe35-2a0f-4180-a1e0-18fb290363f8', N'Agent', N'Binod', 9308023986, N'akashmadhu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T23:32:06.533' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'deb9f2b1-757f-43df-bd7e-1d9f4bbf228e', N'Basil', N'Babu', 349089233, N'basilbabu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-28T01:15:31.013' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'b68f17a1-9988-476a-a8ba-20834cc1d41b', N'Ticket Agent', N'agent', 2214866191, N'agentteicket@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T15:18:32.560' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'eb378d88-8d54-4c4b-ac4d-21045037a0c9', N'Customer', N'Test', 0, N'customertesting@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T15:16:15.150' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'5fa8fead-3079-4767-ba53-26c4df23a63e', N'Amal', N'Vinod', 9497630192, N'akashmadhu8900@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T19:42:55.827' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'6dc57767-73f9-4b29-8bf6-2bd2aa26e10e', N'ABCD', N'EFFGH', 9871239782, N'abcd@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T20:26:26.877' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'1b24700c-0274-42cd-b3f9-39505942aa37', N'Agent', N'Dohngra', 9308023987, N'akashmadhu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T23:33:35.497' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'7d92bf3a-0215-4d05-85e5-41d0b4b39052', N'Customer', N'Ticketdesk', 0, N'ticketdeskcustomer12@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T15:34:09.437' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'd9a200c8-8f76-4f49-a561-4c098ea063f7', N'Agent', N'Bumbum', 198911812233, N'agentbumbum@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-29T21:25:38.307' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'53f5ddc1-b035-45e2-9c24-56556605a647', N'TestingCustomer', N'TicketDesk', 0, N'customercreating@ticketdesk.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T17:46:58.763' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'db7750ef-0607-4246-a22f-5d645301965f', N'sdaksk', N'sadas', 0, N'sadas@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T12:07:46.587' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'650ef4dd-caf8-4aec-ad32-5e0100ede979', N'Test', N'Customer', 3094249234, N'testcustomer@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T14:29:26.853' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'9440c231-9a37-4396-b8bf-706498c70d67', N'Akshay', N'Vinod', 9188492468, N'akshayvinod1@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T20:23:48.273' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'd074eb33-1399-473c-b949-7b85f6686bc0', N'Jithu', N'Sebu', 9128493468, N'jithu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-28T06:29:57.960' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'316b73fc-a7ce-459e-a1ed-7bcb9614f275', N'AkashTicketDesk', N'Customer', 0, N'akashticketdesk@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T17:54:22.500' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'4e14a275-20ac-44f7-94d9-7e04e4e76e3d', N'Allan', N'Varghese', 3248230923, N'allanvarghese12@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-28T01:23:02.703' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'f5aa384f-77fa-4368-a0cf-8646f804bdca', N'Ticket', N'Customer', 0, N'ticketdesk@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T14:25:17.890' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'60fe1af8-403a-4510-9293-8b080e69fc16', N'Midhu', N'Mohan', 9807430703, N'midhumohan0031@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-28T01:07:40.373' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'a7b8345a-187b-4638-90da-8b3ea0cb0f8b', N'AllanDesk', N'Desk', 0, N'allandesk@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-07-01T00:44:27.507' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'c48ed2a8-a362-408b-ab62-926cb7cc8414', N'Agent', N'57', 5757675757, N'akash67@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T23:50:50.257' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'64c0d9ed-5a10-4290-9e89-94ea0b350b4b', N'Sample', N'Agent', 1234567890, N'sampleagent@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T20:34:15.177' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'4d1494ea-8a1e-436c-aa73-a52b57e28113', N'Ashwin', N'Madhu', 8075319645, N'akash.madhu468@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T18:56:11.683' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'08e6f820-af22-435b-9766-acb1862745c5', N'Dumpling', N'Pradhan', 4230948902, N'dumpling@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T11:26:12.833' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'8b463d89-8c3a-4862-b755-b7963f9c10c5', N'TciecketDeskAgent', N'Agent', 8786484929, N'testingcustomer@ticketdesk.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T17:49:26.147' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'e6307285-b925-40a0-9cc9-ba10f417c7af', N'Agent', N'TicketDesk', 77777777777, N'akashmadhu77777777777@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-07-01T01:57:52.503' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'de8d30fd-0c75-44d8-ad2e-c042c6b953ff', N'Testing', N'Customer', 0, N'testingcustomer@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 4, CAST(N'2024-06-30T17:35:31.570' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'50b70d79-80c2-4869-a2fe-cab40c9d2efe', N'Agent', N'TicketDesk', 7777665666, N'akashmadhu77766656777@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-07-01T01:59:59.093' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'd5bfbdf1-662b-46df-9520-d0c01be682be', N'Agent', N'Nunu', 92349234834, N'agentnunu@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-29T22:43:03.287' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'b75bdfaa-b48a-43f6-86ee-dc39f7f99160', N'Akash', N'agent', 947630192, N'akashagent@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T15:25:00.990' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'a602efab-788a-4f6b-a4ed-de6a5fbf8514', N'Akshay', N'Vinod', 9234889314, N'akshayvinod@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-23T20:08:01.777' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'8a17ff0f-1536-4dd5-ae7a-eaa7f4801b31', N'TicketDeskAgent', N'TicketDeskAgent', 0, N'ticketdeskagent12@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T17:56:50.863' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'4444d748-6f64-4b2b-b031-ead6c0565265', N'Akash', N'Agent', 9497630292, N'akashagent1@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 3, CAST(N'2024-06-30T15:28:41.867' AS DateTime))
INSERT [dbo].[Users] ([UserId], [FirstName], [LastName], [PhoneNumber], [EmailAddress], [Password], [RoleId], [CreatedOn]) VALUES (N'7fe92677-f923-4e29-8fc2-ecc03062dfee', N'Akash', N'Madhu', 9188493468, N'akashmadhu824@gmail.com', N'71zo57D0fTJhPy5F+VSLNA==', 2, CAST(N'2024-06-22T14:36:34.887' AS DateTime))
GO
ALTER TABLE [dbo].[Agents] ADD  CONSTRAINT [DF_Agents_CustomerId]  DEFAULT (newid()) FOR [AgentId]
GO
ALTER TABLE [dbo].[Agents] ADD  CONSTRAINT [DF_Agents_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Agents] ADD  CONSTRAINT [DF_Agents_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[AgentTicketMapping] ADD  CONSTRAINT [DF_AgentTicketMapping_MappingId]  DEFAULT (newid()) FOR [MappingId]
GO
ALTER TABLE [dbo].[AgentTicketMapping] ADD  CONSTRAINT [DF_AgentTicketMapping_AgentId]  DEFAULT (newid()) FOR [AgentId]
GO
ALTER TABLE [dbo].[AgentTicketMapping] ADD  CONSTRAINT [DF_AgentTicketMapping_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[AgentTicketMapping] ADD  CONSTRAINT [DF_AgentTicketMapping_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[ApplicationLogs] ADD  CONSTRAINT [DF_ApplicationLogs_LogId]  DEFAULT (newid()) FOR [LogId]
GO
ALTER TABLE [dbo].[ApplicationLogs] ADD  CONSTRAINT [DF_ApplicationLogs_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [DF_Applications_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[LoginLogs] ADD  CONSTRAINT [DF_LoginLogs_LginLogId]  DEFAULT (newid()) FOR [LginLogId]
GO
ALTER TABLE [dbo].[LoginLogs] ADD  CONSTRAINT [DF_LoginLogs_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Status] ADD  CONSTRAINT [DF_Status_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_TicketId]  DEFAULT (newid()) FOR [TicketId]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [DF_Tickets_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[TicketTypes] ADD  CONSTRAINT [DF_TicketTypes_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_ProfileId]  DEFAULT (newid()) FOR [ProfileId]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_UserId]  DEFAULT (newid()) FOR [UserId]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[UserProfile] ADD  CONSTRAINT [DF_UserProfile_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_UserId]  DEFAULT (newid()) FOR [UserId]
GO
ALTER TABLE [dbo].[Agents]  WITH CHECK ADD  CONSTRAINT [FK_Agents_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Agents] CHECK CONSTRAINT [FK_Agents_Users]
GO
ALTER TABLE [dbo].[Agents]  WITH CHECK ADD  CONSTRAINT [FK_Agents_Users1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Agents] CHECK CONSTRAINT [FK_Agents_Users1]
GO
ALTER TABLE [dbo].[Agents]  WITH CHECK ADD  CONSTRAINT [FK_Agents_Users2] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Agents] CHECK CONSTRAINT [FK_Agents_Users2]
GO
ALTER TABLE [dbo].[AgentTicketMapping]  WITH CHECK ADD  CONSTRAINT [FK_AgentTicketMapping_Agents] FOREIGN KEY([AgentId])
REFERENCES [dbo].[Agents] ([AgentId])
GO
ALTER TABLE [dbo].[AgentTicketMapping] CHECK CONSTRAINT [FK_AgentTicketMapping_Agents]
GO
ALTER TABLE [dbo].[AgentTicketMapping]  WITH CHECK ADD  CONSTRAINT [FK_AgentTicketMapping_Tickets] FOREIGN KEY([TicketId])
REFERENCES [dbo].[Tickets] ([TicketId])
GO
ALTER TABLE [dbo].[AgentTicketMapping] CHECK CONSTRAINT [FK_AgentTicketMapping_Tickets]
GO
ALTER TABLE [dbo].[AgentTicketMapping]  WITH CHECK ADD  CONSTRAINT [FK_AgentTicketMapping_Users1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AgentTicketMapping] CHECK CONSTRAINT [FK_AgentTicketMapping_Users1]
GO
ALTER TABLE [dbo].[AgentTicketMapping]  WITH CHECK ADD  CONSTRAINT [FK_AgentTicketMapping_Users2] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AgentTicketMapping] CHECK CONSTRAINT [FK_AgentTicketMapping_Users2]
GO
ALTER TABLE [dbo].[ApplicationLogs]  WITH CHECK ADD  CONSTRAINT [FK_ApplicationLogs_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[ApplicationLogs] CHECK CONSTRAINT [FK_ApplicationLogs_Users]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Applications] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([DepartmentId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Applications]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Status]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_TicketTypes] FOREIGN KEY([TicketTypeId])
REFERENCES [dbo].[TicketTypes] ([TicketTypeId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_TicketTypes]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Users]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Users1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Users1]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Countries]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Genders] FOREIGN KEY([GenderId])
REFERENCES [dbo].[Genders] ([GenderId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Genders]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Users]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Users1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Users1]
GO
ALTER TABLE [dbo].[UserProfile]  WITH CHECK ADD  CONSTRAINT [FK_UserProfile_Users2] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserProfile] CHECK CONSTRAINT [FK_UserProfile_Users2]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateAgent]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 23 June 2024
-- Description:	To create a customer
--EXEC usp_CreateCustomer 'Ashwin','Madhu','akash.madhu468@gmail.com',8075319645,'19891181Aa*'
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreateAgent]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @PhoneNumber BIGINT,
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @UserId UNIQUEIDENTIFIER = NEWID();
    DECLARE @AgentId UNIQUEIDENTIFIER = NEWID();

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into Users table
        INSERT INTO [dbo].[Users]
           ([UserId]
           ,[FirstName]
           ,[LastName]
           ,[PhoneNumber]
           ,[EmailAddress]
           ,[Password]
           ,[RoleId]
           ,[CreatedOn])
        VALUES 
           (@UserId,
           @FirstName,
           @LastName,
           @PhoneNumber,
           @Email,
           @Password,
           3, 
           GETDATE());

		   INSERT INTO [dbo].[UserProfile]
           ([ProfileId]
           ,[UserId]
           ,[CreatedOn])
     VALUES
           (NEWID(),
		   @UserId,
		   GETDATE())

		   
        -- Insert into Agent table
        INSERT INTO [dbo].[Agents]
           ([AgentId]
           ,[UserId]
           ,[CreatedOn]
           ,[CreatedBy])
        VALUES
           (@AgentId,
           @UserId,
           GETDATE(),
           @UserId);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateTicket]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To create a Ticket
/*
DECLARE @Now DATETIME = GETDATE();
DECLARE @UserId UNIQUEIDENTIFIER = SELECT TOP 1 UserId FROM Users;

EXEC usp_CreateTicket
    @TicketTypeId = 1,
    @DepartmentId = 9,
    @TicketTitle = 'Sample Ticket Title',
    @TicketDescription = 'This is a sample ticket description.',
    @StatusId = 1,
    @CreatedOn = @Now,
    @CreatedBy = @UserId,
    @ModifiedOn = @Now,
    @ModifiedBy = @UserId;
*/
-- =============================================
CREATE PROCEDURE [dbo].[usp_CreateTicket]
    @TicketTitle NVARCHAR(150),
    @TicketDescription NVARCHAR(MAX),
    @StatusId INT,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [dbo].[Tickets]
            ([TicketId]
            ,[TicketTitle]
            ,[TicketDescription]
            ,[StatusId]
			,[CreatedOn]
			,[CreatedBy])
        VALUES
            (NewID()
            ,@TicketTitle
            ,@TicketDescription
            ,@StatusId
			,GETDATE()
            ,@UserId);

		SELECT @@ROWCOUNT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log the error details
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteAgent]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:        Akash Madhu
-- Create date:   29 June 2024
-- Description:   Delete an Agent
--EXEC usp_DeleteAgent '80b461d5-a110-406a-af80-216f128ffebe'
-- ================================================
CREATE PROCEDURE [dbo].[usp_DeleteAgent]
    @AgentId UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @UserId UNIQUEIDENTIFIER

    SELECT @UserId = UserId FROM Agents WHERE AgentId = @AgentId
	DELETE FROM AgentTicketMapping WHERE AgentId = @AgentId
    DELETE FROM Agents WHERE AgentId = @AgentId
	DELETE FROM UserProfile WHERE UserId = @UserId
    DELETE FROM Users WHERE UserId = @UserId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_DeleteTicket]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To Delete a ticket
-- EXEC usp_DeleteTicket ''
-- =============================================
CREATE PROCEDURE [dbo].[usp_DeleteTicket]
    @TicketId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		
        UPDATE Tickets 
		SET StatusId = 5
		WHERE TicketId = @TicketId

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAgentById]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:        Akash Madhu
-- Create date:   29 June 2024
-- Description:   Get Agent details by ID
--EXEC usp_GetAgentById ''
-- ================================================
CREATE PROCEDURE [dbo].[usp_GetAgentById]
    @AgentId UNIQUEIDENTIFIER
AS
BEGIN
    SELECT 
        a.AgentId,
        u.UserId,
        u.FirstName,
        u.LastName,
        u.PhoneNumber,
        u.EmailAddress,
        u.Password,
        a.CreatedOn,
        a.CreatedBy,
        a.ModifiedOn,
        a.ModifiedBy
    FROM Agents a
    JOIN Users u ON a.UserId = u.UserId
    WHERE a.AgentId = @AgentId
END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetAgentsPaginated]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 29 June 2024
-- Description:	Get paginated Agent details
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAgentsPaginated]
    @Page INT,
    @Size INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartRow INT = (@Page * @Size) + 1;
    DECLARE @EndRow INT = @StartRow + @Size - 1;

    WITH AgentCTE AS
    (
        SELECT 
            a.AgentId,
            u.UserId,
            u.FirstName,
            u.LastName,
            u.PhoneNumber,
            u.EmailAddress,
            u.Password,
            u.RoleId,
            a.CreatedOn,
            a.CreatedBy,
            a.ModifiedOn,
            a.ModifiedBy,
            ROW_NUMBER() OVER (ORDER BY u.FirstName) AS RowNum
        FROM Agents a
        JOIN Users u ON a.UserId = u.UserId
    )
    SELECT 
        AgentId,
        UserId,
        FirstName,
        LastName,
        PhoneNumber,
        EmailAddress,
        Password,
        RoleId,
        CreatedOn,
        CreatedBy,
        ModifiedOn,
        ModifiedBy
    FROM AgentCTE
    WHERE RowNum BETWEEN @StartRow AND @EndRow;

    SELECT COUNT(*) AS TotalRecords
    FROM Agents a
    JOIN Users u ON a.UserId = u.UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllAgents]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 29 June 2024
-- Description:	Get all Agent details
--EXEC usp_GetAllAgents
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllAgents]
AS
BEGIN
    SELECT 
        a.AgentId,
        u.UserId,
        u.FirstName,
        u.LastName,
        u.PhoneNumber,
        u.EmailAddress,
        u.Password,
        a.CreatedOn,
        a.CreatedBy,
        a.ModifiedOn,
        a.ModifiedBy
    FROM Agents a
    JOIN Users u ON a.UserId = u.UserId
	JOIN Roles r ON r.RoleId = u.RoleId
	WHERE r.RoleId = 3
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllTickets]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	Get All tickets
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetAllTickets]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TicketId,
        TicketTypeId,
        DepartmentId,
        TicketTitle,
        TicketDescription,
        StatusId,
        CreatedOn,
        CreatedBy,
        ModifiedOn,
        ModifiedBy
    FROM 
        [dbo].[Tickets] WITH (NOLOCK);
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMasterData]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To get all the master data
--EXEC usp_GetMasterData
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetMasterData] 
AS
BEGIN
	SELECT [CountryId] AS Id,[CountryName] AS DisplayName FROM [dbo].[Countries]
	SELECT [GenderId] AS Id,[GenderName] AS DisplayName FROM [dbo].[Genders]
	SELECT [DepartmentId] AS Id,[DepartmentName] AS DisplayName FROM [dbo].[Departments]
	SELECT [RoleId] AS Id,[RoleName] AS DisplayName FROM [dbo].[Roles]
	SELECT [StatusId] AS Id,[StatusName] AS DisplayName FROM [dbo].[Status]
	SELECT [TicketTypeId] AS Id,[TicketTypeName] AS DisplayName FROM [dbo].[TicketTypes]
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTicketById]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To get a ticket by ID
--EXEC usp_GetTicketById ''
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetTicketById]
    @TicketId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TicketId,
        TicketTypeId,
        DepartmentId,
        TicketTitle,
        TicketDescription,
        StatusId,
        CreatedOn,
        CreatedBy,
        ModifiedOn,
        ModifiedBy
    FROM 
        [dbo].[Tickets] 
    WHERE 
        TicketId = @TicketId
		AND StatusId != 5;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTicketByUser]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To get a ticket by ID
--EXEC usp_GetTicketByUser 'CEB56B3C-E7D1-44DE-83E4-0BDCC2C2BA70'
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetTicketByUser]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        TicketId,
        TicketTypeId,
        DepartmentId,
        TicketTitle,
        TicketDescription,
        StatusId,
        CreatedOn,
        CreatedBy,
        ModifiedOn,
        ModifiedBy
    FROM 
        [dbo].[Tickets] 
    WHERE 
        CreatedBy = @UserId
		AND StatusId != 5;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTicketsByAgent]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 29 June 2024
-- Description:	Get Tickets Assigned to Agent
-- EXEC usp_GetTicketsByAgent @AgentId
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetTicketsByAgent]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @AgentId UNIQUEIDENTIFIER;
	SELECT @AgentId = AgentId FROM Agents WHERE UserId = @UserId
    SELECT 
        t.TicketId,
        t.TicketTypeId,
        t.DepartmentId,
        t.TicketTitle,
        t.TicketDescription,
        t.StatusId,
        t.CreatedOn,
        t.CreatedBy,
        t.ModifiedOn,
        t.ModifiedBy
    FROM AgentTicketMapping atm
    JOIN Tickets t ON atm.TicketId = t.TicketId
    WHERE atm.AgentId = @AgentId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTicketsWithAgent]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 30 June 2024
-- Description:	Get Ticket with agent assinged
--EXEC usp_GetTicketsWithAgent
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetTicketsWithAgent]
AS
BEGIN
    SELECT 
        t.TicketId,
        t.TicketTitle,
        t.TicketDescription,
        t.StatusId,
        ISNULL(a.AgentId, '00000000-0000-0000-0000-000000000000') AS AgentId,
        ISNULL(u.FirstName + ' ' + u.LastName, 'Unknown') AS AgentName
    FROM 
        Tickets t
    LEFT JOIN 
        AgentTicketMapping atm ON t.TicketId = atm.TicketId
    LEFT JOIN 
        Agents a ON a.AgentId = atm.AgentId
	LEFT JOIN
		Users u ON u.UserId = a.UserId
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserProfile]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 23 June 2024
-- Description:	Get User Profile By UserId
--EXEC usp_GetUserProfile 'CEB56B3C-E7D1-44DE-83E4-0BDCC2C2BA70'
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetUserProfile]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            ProfileId,
            UP.UserId,
            DisplayName,
            GenderId,
            CountryId,
			U.FirstName,
			U.LastName,
			U.EmailAddress,
			U.PhoneNumber
        FROM 
            [dbo].[UserProfile] UP
		JOIN Users U
		ON U.UserId = UP.UserId
        WHERE 
            UP.UserId = @UserId;
    END TRY
    BEGIN CATCH
        -- Log the error details
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserRoles]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 23 June 2024
-- Description:	To Get User Role
-- EXEC usp_GetUserRoles ''
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetUserRoles]
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT r.RoleName
    FROM [dbo].[UserRoles] ur
    JOIN [dbo].[Roles] r ON ur.RoleId = r.RoleId
    WHERE ur.UserId = @UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_RegisterUser]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	Register a new User
--EXEC usp_RegisterUser 'Akash','Madhu','akashmadhu824@gmail.com','9188493468','19891181Aa*',1
-- =============================================
CREATE PROCEDURE [dbo].[usp_RegisterUser]
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @PhoneNumber BIGINT,
    @Password NVARCHAR(100),
    @RoleId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
		DECLARE @UserID UNIQUEIDENTIFIER = NEWID();
        INSERT INTO [dbo].[Users]
           ([UserId]
           ,[FirstName]
           ,[LastName]
           ,[PhoneNumber]
           ,[EmailAddress]
           ,[Password]
           ,[RoleId]
           ,[CreatedOn])
        VALUES 
           (@UserID,
           @FirstName,
           @LastName,
           @PhoneNumber,
           @Email,
           @Password,
           @RoleId,
           GETDATE());

		   INSERT INTO [TicketDesk].[dbo].[UserProfile]
               ([ProfileId]
               ,[UserId]
               ,[CreatedOn]
               ,[CreatedBy]
               ,[ModifiedOn])
        VALUES
               (NEWID(), 
                @UserId,  
                GETDATE(), 
                @UserID,
				Null);
        SELECT @@ROWCOUNT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log the error details
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateAgent]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ================================================
-- Author:        Akash Madhu
-- Create date:   29 June 2024
-- Description:   Create a new Agent
-- ================================================
-- ================================================
-- Author:        Akash Madhu
-- Create date:   29 June 2024
-- Description:   Update Agent details
-- ================================================
CREATE PROCEDURE [dbo].[usp_UpdateAgent]
    @AgentId UNIQUEIDENTIFIER,
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @PhoneNumber NVARCHAR(15),
    @EmailAddress NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    UPDATE Users
    SET 
        FirstName = @FirstName,
        LastName = @LastName,
        PhoneNumber = @PhoneNumber,
        EmailAddress = @EmailAddress,
        Password = @Password
    WHERE UserId = (SELECT UserId FROM Agents WHERE AgentId = @AgentId)
END


GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateTicket]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To update a Ticket
--EXEC usp_UpdateTicket
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateTicket]
    @TicketId UNIQUEIDENTIFIER,
    @TicketTitle NVARCHAR(150),
    @TicketDescription NVARCHAR(MAX),
    @StatusId INT,
    @UserId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE [dbo].[Tickets]
        SET [TicketTitle] = @TicketTitle,
            [TicketDescription] = @TicketDescription,
            [StatusId] = @StatusId,
            [ModifiedOn] = GETDATE(),
            [ModifiedBy] = @UserId
        WHERE [TicketId] = @TicketId;

        -- Return the number of affected rows
        SELECT @@ROWCOUNT;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log the error details
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateUserProfile]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	To update user profile
--EXEC usp_UpdateUserProfile
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpdateUserProfile]
    @ProfileId UNIQUEIDENTIFIER,
    @UserId UNIQUEIDENTIFIER,
    @DisplayName NVARCHAR(20),
    @GenderId INT,
    @CountryId INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @PhoneNumber BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE 
			[dbo].[UserProfile]
		SET
			DisplayName = @DisplayName,
			GenderId = @GenderId,
			CountryId = @CountryId,
			ModifiedOn = GETDATE(),
			ModifiedBy = @UserId
		WHERE
			ProfileId = @ProfileId AND
			UserId = @UserId;

		UPDATE 
			[dbo].[Users]
		SET
			FirstName = @FirstName,
			LastName = @LastName,
			EmailAddress = @Email,
			PhoneNumber = @PhoneNumber
		WHERE
			UserId = @UserId;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Log the error details
        DECLARE @ErrorMessage NVARCHAR(4000),
                @ErrorSeverity INT,
                @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_UpsertAgentTicketMapping]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Akash Madhu
-- Create date:   29 June 2024
-- Description:   Insert or Update Agent Ticket Mapping based on TicketId existence
-- EXEC usp_UpsertAgentTicketMapping @AgentId, @TicketId, @CreatedBy
-- =============================================
CREATE PROCEDURE [dbo].[usp_UpsertAgentTicketMapping]
    @AgentId UNIQUEIDENTIFIER,
    @TicketId UNIQUEIDENTIFIER,
    @CreatedBy UNIQUEIDENTIFIER
AS
BEGIN
    IF EXISTS (SELECT 1 FROM AgentTicketMapping WHERE TicketId = @TicketId)
    BEGIN
        UPDATE AgentTicketMapping
        SET AgentId = @AgentId, 
            ModifiedOn = GETDATE(), 
            ModifiedBy = @CreatedBy
        WHERE TicketId = @TicketId
    END
    ELSE
    BEGIN
        -- Insert new record if TicketId does not exist
        INSERT INTO AgentTicketMapping (MappingId, AgentId, TicketId, CreatedOn, CreatedBy, ModifiedOn, ModifiedBy)
        VALUES (NEWID(), @AgentId, @TicketId, GETDATE(), @CreatedBy, NULL, NULL)
    END
END
GO
/****** Object:  StoredProcedure [dbo].[usp_ValidateUser]    Script Date: 01-07-2024 02:15:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	Validate user using user credentials
--EXEC usp_ValidateUser 'akashmadhu824@gmail.com','19891181Aa*'
-- =============================================
CREATE PROCEDURE [dbo].[usp_ValidateUser]
    @Email NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        UserId,
        FirstName,
        LastName,
        EmailAddress,
        U.RoleId,
        R.RoleName 
    FROM 
        [dbo].[Users] AS U
		JOIN 
		[dbo].[Roles] AS R
		ON 
		U.RoleId = R.RoleId
    WHERE 
        EmailAddress = @Email
        AND Password = @Password;
END

GO
USE [master]
GO
ALTER DATABASE [TicketDesk] SET  READ_WRITE 
GO
