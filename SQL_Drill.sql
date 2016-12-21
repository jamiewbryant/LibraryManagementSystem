--------------------Book-------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Book]    Script Date: 12/21/2016 6:27:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Book](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](50) NULL,
	[PublisherName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

--------------------------Book_Authors-----------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Book_Authors]    Script Date: 12/21/2016 6:28:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Book_Authors](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [Books].[Book_Authors]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Books].[Book] ([BookID])
GO

-------------------------------Book_Copies-------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Book_Copies]    Script Date: 12/21/2016 6:29:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Books].[Book_Copies](
	[BookID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[No_Of_Copies] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [Books].[Book_Copies]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Books].[Book] ([BookID])
GO

ALTER TABLE [Books].[Book_Copies]  WITH CHECK ADD FOREIGN KEY([BranchID])
REFERENCES [Books].[Library_Branch] ([BranchID])
GO

---------------------------------------Book_Loans---------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Book_Loans]    Script Date: 12/21/2016 6:30:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Book_Loans](
	[BookID] [int] NOT NULL,
	[BranchID] [int] NOT NULL,
	[CardNo] [int] NOT NULL,
	[DateOut] [varchar](50) NULL,
	[DueDate] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [Books].[Book_Loans]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [Books].[Book] ([BookID])
GO

ALTER TABLE [Books].[Book_Loans]  WITH CHECK ADD FOREIGN KEY([BranchID])
REFERENCES [Books].[Library_Branch] ([BranchID])
GO

ALTER TABLE [Books].[Book_Loans]  WITH CHECK ADD FOREIGN KEY([CardNo])
REFERENCES [Books].[Borrower] ([CardNo])
GO

----------------Borrower-------------------------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Borrower]    Script Date: 12/21/2016 6:30:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Borrower](
	[CardNo] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CardNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

----------------------Library_Branch-----------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Library_Branch]    Script Date: 12/21/2016 6:31:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Library_Branch](
	[BranchID] [int] IDENTITY(1,1) NOT NULL,
	[BranchName] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BranchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

---------------------Publisher--------------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  Table [Books].[Publisher]    Script Date: 12/21/2016 6:32:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [Books].[Publisher](
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](50) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


--Problem1Or2-------------------------------------------------------
USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem1Or2]    Script Date: 12/21/2016 5:37:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem1Or2]
@BranchName varchar(50),
@Title varchar(50)
as
select No_Of_Copies, Title, BranchName from Books.Book as Book
inner join Books.Book_Copies as Copies
on Book.BookID = Copies.BookID
inner join Books.Library_Branch as Branch
on Copies.BranchID = Branch.BranchID
where (@BranchName is Null or (BranchName = @BranchName))
and (@Title is null or (Title = @Title)) 
GO

---Problem3---------------------------------------------

USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem3]    Script Date: 12/21/2016 5:38:31 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem3]
as
select Name from Books.Borrower as Borrower
inner join Books.Book_Loans as Loans
on Borrower.CardNo = Loans.CardNo
where DueDate is NULL
GO

-------------Problem4-------------------------------------------

USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem4]    Script Date: 12/21/2016 5:39:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem4]
as
select Title, Name, Address, DueDate from Books.Borrower as Borrower
inner join Books.Book_Loans as Loans
on Borrower.CardNo = Loans.CardNo
inner join Books.Book as Book
on Book.BookID = Loans.BookID
where Loans.DueDate = '20Dec2016'
and Loans.BranchID = 3
GO

---------------Problem5-------------------------------------------

USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem5]    Script Date: 12/21/2016 5:40:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem5]
as
Select Branch.BranchName, loans.BranchID, Count(Loans.DueDate)
as
LoanedOut
from Books.Library_Branch as Branch
left join Books.Book_Loans as Loans
on Loans.BranchID = Branch.BranchID
Group by loans.BranchID, BranchName
GO

--------------------Problem6---------------------------

USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem6]    Script Date: 12/21/2016 5:41:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem6]
as

select Borrower.Name, Borrower.Address, count(Borrower.Name) 
as NumberOfBooks
from Books.Borrower as Borrower
group by Borrower.Name, Borrower.Address
having count(Borrower.Name) >5
GO

-----------------Problem7------------------------------------

USE [LibraryManagementSystem]
GO

/****** Object:  StoredProcedure [dbo].[Problem7]    Script Date: 12/21/2016 5:41:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Problem7]
as
Select distinct Book.Title, Copies.No_Of_Copies From Books.Book_Copies as Copies
inner join Books.Book as Book
on Book.BookID = Copies.No_Of_Copies
inner join Books.Book_Authors as Authors
on Book.BookID = Authors.BookID
inner join Books.Library_Branch as Branch
on Copies.BranchID = Branch.BranchID
where AuthorName = 'Stephen King'
and BranchName= 'Central'
GO


