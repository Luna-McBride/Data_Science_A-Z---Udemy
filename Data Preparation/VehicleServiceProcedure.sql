USE [DSTRAIN]
GO
/****** Object:  StoredProcedure [dbo].[__tmpl__BLD_WRK__VehicleServices]    Script Date: 2/10/2020 5:32:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROC [dbo].[BLD_WRK_VehicleServices]
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
if object_id('WRK_VehicleServices') is not null
drop table [WRK_VehicleServices]

-- =============================================
-- Create Table
-- =============================================
create table [WRK_VehicleServices](
	[RowNumber]		int identity(1,1)
	,[CustomerID]	varchar(100)
	,[CustomerSince] date
	,[Vehicle]		varchar(1000)
	,[2014]			float
	,[2015]			float
	,[2016E]		float
)

-- =============================================
-- Truncate Table
-- =============================================
truncate table [WRK_VehicleServices]

-- =============================================
-- Insert Into
-- =============================================
insert into [WRK_VehicleServices](
	[CustomerID]
	,[CustomerSince]
	,[Vehicle]
	,[2014]
	,[2015]
	,[2016E]
)
select [CustomerID]
      ,[CustomerSince]
      ,[Vehicle]
      ,[2014]
      ,[2015]
      ,[2016E]
from [dbo].[RAW_VehicleServices_20200210]

--Sanity Check: 
SELECT sum([2016E])
  FROM [DSTRAIN].[dbo].[WRK_VehicleServices]
-- Result: 419896187.869989
-- 419896187.869989 = 419896187.87 
-- All formatted correctly

--==============================================
-- Error Fixes
--==============================================

-- Error: empty 2014 column
update [RAW_VehicleServices_20200210]
set [2014]='0'
where ISNUMERIC([2014])=0
--(31878 rows affected)

-- Error: 2015 column has $ instead of . on one row
update [RAW_VehicleServices_20200210]
set [2015]='781.37'
where isNumeric([2015])=0
--(1 row affected)

-- Insert automatically-filtered data
insert into [WRK_VehicleServices] (CustomerID, CustomerSince, Vehicle, [2014], [2015], [2016E])
values ('3534844', '2010-12-29', '2011 Honda Element', 604.96, 300.96, 17.51)
-- (1 row affected)

END

/*
	select * from [dbo].[RAW_VehicleServices_20200210]
	select * from [dbo].[WRK_VehicleServices]
*/
