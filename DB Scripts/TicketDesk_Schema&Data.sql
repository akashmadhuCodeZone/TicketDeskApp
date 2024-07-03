USE [master]
GO
/****** Object:  Database [TicketDesk]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  User [Q-LT-2024-025\Akash.Madhu]    Script Date: 03-07-2024 06:17:18 ******/
CREATE USER [Q-LT-2024-025\Akash.Madhu] FOR LOGIN [Q-LT-2024-025\Akash.Madhu] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Q-LT-2024-025\Akash.Madhu]
GO
/****** Object:  Schema [TicketDesk.dbo]    Script Date: 03-07-2024 06:17:18 ******/
CREATE SCHEMA [TicketDesk.dbo]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[AgentTicketMapping]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[ApplicationLogs]    Script Date: 03-07-2024 06:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ApplicationLogs](
	[LogId] [uniqueidentifier] NOT NULL,
	[LogLevel] [nvarchar](20) NULL,
	[ErrorDiscription] [nvarchar](max) NULL,
	[SatckTrace] [nvarchar](max) NULL,
	[TraceDiscription] [nvarchar](150) NULL,
	[CreatedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_ApplicationLogs] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Departments]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Genders]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Status]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Tickets]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[TicketTypes]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[UserProfile]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_InsertApplicationLog]    Script Date: 03-07-2024 06:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 29 June 2024
-- Description:	Log traces and errors to Log Table
-- =============================================
CREATE PROCEDURE [dbo].[sp_InsertApplicationLog]
    @LogLevel NVARCHAR(50),
    @ErrorDescription NVARCHAR(MAX) = NULL,
    @StackTrace NVARCHAR(MAX) = NULL,
    @TraceDescription NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO [dbo].[ApplicationLogs]
           ([LogId]
           ,[LogLevel]
           ,[ErrorDiscription]
           ,[SatckTrace]
           ,[TraceDiscription]
           ,[CreatedOn])
     VALUES
           (NEWID()
           ,@LogLevel
           ,@ErrorDescription
           ,@StackTrace
           ,@TraceDescription
           ,GETDATE())
END


GO
/****** Object:  StoredProcedure [dbo].[usp_CreateAgent]    Script Date: 03-07-2024 06:17:18 ******/
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
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[usp_CreateTicket]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_DeleteAgent]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_DeleteTicket]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetAgentById]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetAgentsPaginated]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetAllAgents]    Script Date: 03-07-2024 06:17:18 ******/
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
	ORDER BY CreatedOn DESC
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetAllTickets]    Script Date: 03-07-2024 06:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 22 June 2024
-- Description:	Get All tickets
--EXEC usp_GetAllTickets
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
        [dbo].[Tickets] WITH (NOLOCK)
	ORDER BY CreatedOn DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetMasterData]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetTicketById]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetTicketByUser]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_GetTicketsByAgent]    Script Date: 03-07-2024 06:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 29 June 2024
-- Description:	Get Tickets Assigned to Agent
-- EXEC usp_GetTicketsByAgent 'F309875D-09BA-418C-9DC3-D8097DA530CC'
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
	ORDER BY CreatedOn DESC
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetTicketsWithAgent]    Script Date: 03-07-2024 06:17:18 ******/
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
	ORDER BY t.ModifiedOn DESC
END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetUserProfile]    Script Date: 03-07-2024 06:17:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Akash Madhu
-- Create date: 23 June 2024
-- Description:	Get User Profile By UserId
--EXEC usp_GetUserProfile 'f309875d-09ba-418c-9dc3-d8097da530cc'
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
            UP.UserId LIKE @UserId;
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
/****** Object:  StoredProcedure [dbo].[usp_RegisterUser]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_UpdateAgent]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_UpdateTicket]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_UpdateUserProfile]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_UpsertAgentTicketMapping]    Script Date: 03-07-2024 06:17:18 ******/
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
/****** Object:  StoredProcedure [dbo].[usp_ValidateUser]    Script Date: 03-07-2024 06:17:18 ******/
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
