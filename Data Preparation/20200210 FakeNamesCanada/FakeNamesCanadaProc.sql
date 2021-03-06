USE [DSTRAIN]
GO
/****** Object:  StoredProcedure [dbo].[__tmpl__BLD_WRK__FakeNamesCanada]    Script Date: 2/10/2020 9:57:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROC [dbo].[BLD_WRK_FakeNamesCanada]
-- =============================================
-- Author: Luna McBride
-- Create date: 20200210
-- Description:	RAW -> WRK
-- Mod Date:
-- =============================================


AS
BEGIN
-- =============================================
-- Drop Table
-- =============================================
if object_id('WRK_FakeNamesCanada') is not null
drop table [WRK_FakeNamesCanada]

-- =============================================
-- Create Table
-- =============================================
create table [WRK_FakeNamesCanada](
	[RowNumber]		int identity(1,1)
	,[Number]		varchar(100)
	,[Gender]		varchar(10)
	,[GivenName]	varchar(1000)
	,[Surname]		varchar(1000)
	,[StreetAddress] varchar(1000)
	,[City]			varchar (1000)
	,[ZipCode]		varchar(7)
	,[CountryFull]	varchar(100)
	,[Birthday]		date
	,[Balance]		float
	,[InterestRate]	float
)

-- =============================================
-- Truncate Table
-- =============================================
truncate table [WRK_FakeNamesCanada]

-- =============================================
-- Insert Into
-- =============================================
insert into [WRK_FakeNamesCanada](
	[Number]
	,[Gender]
	,[GivenName]
	,[Surname]
	,[StreetAddress]
	,[City]
	,[ZipCode]
	,[CountryFull]
	,[Birthday]
	,[Balance]
	,[InterestRate]
)
select [Number]
      ,[Gender]
      ,[GivenName]
      ,[Surname]
      ,[StreetAddress]
      ,[City]
      ,[ZipCode]
      ,[CountryFull]
      ,[Birthday]
      ,[Balance]
      ,[InterestRate]
from [dbo].[RAW_FakeNamesCanada_20200210]
--Filter
where isnumeric([Balance]) = 1 --10 Rows Excluded
and len([ZipCode]) <= 7		   --2 Rows Excluded
and isdate([Birthday]) = 1	   --1 Row Excluded
-- (199987 rows affected)
-- 199987+1+2+10=200000

-- =============================================
-- Additional Exclusions
-- =============================================
delete from [WRK_FakeNamesCanada]
where [Balance] <0
-- (1 row affected)

delete from [WRK_FakeNamesCanada]
where [ZipCode] not like '___ ___'
-- (4 rows affected)


--Included in tutorial, but such value does not exist here
--delete from [WRK_FakeNamesCanada]
--where [Birthday] < '1915-08-13'

delete from [WRK_FakeNamesCanada]
where [Birthday] > '2005-08-13'
-- (1 row affected)

END

/*
	select * from [dbo].[RAW_FakeNamesCanada_yyyymmdd]
	select * from [dbo].[WRK_FakeNamesCanada]
	select count(*) from [dbo].[WRK_FakeNamesCanada]
*/
