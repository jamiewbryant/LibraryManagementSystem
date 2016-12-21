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


