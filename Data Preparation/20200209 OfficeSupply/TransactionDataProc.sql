USE [DSTRAIN]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_TransactionData]    Script Date: 2/10/2020 4:02:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_TransactionData]
-- =============================================
-- Author:		Luna McBride
-- Create date: 20200209
-- Description:	RAW -> WRK
-- Mod Date:
-- =============================================


AS
BEGIN
-- =============================================
-- Drop Table
-- =============================================
if object_id('WRK_TransactionData') is not null
drop table [WRK_TransactionData]

-- =============================================
-- Create Table
-- =============================================
create table [WRK_TransactionData](
	[RowNumber]		int identity(1,1)
	,[Order ID]		varchar(100)
	,[Order Date]	date
	,[Customer ID]	varchar(100)
	,[Region]		varchar(1)
	,[Rep]			varchar(100)
	,[Item]			varchar(1000)
	,[Units]		int
	,[Unit Price]	float
)

-- =============================================
-- Truncate Table
-- =============================================
truncate table [WRK_TransactionData]

-- =============================================
-- Insert Into
-- =============================================
insert into [WRK_TransactionData](
	[Order ID]
	,[Order Date]
	,[Customer ID]
	,[Region]
	,[Rep]
	,[Item]
	,[Units]
	,[Unit Price]
)
select [Order ID]
    ,[Order Date]
    ,right('0000000'+[Customer ID],7)
    ,[Region]
    ,[Rep]
    ,[Item]
    ,[Units]
    ,[Unit Price]
from [dbo].[RAW_TransactionData_20200209]
--(43 rows affected)

END

/*
	select * from [dbo].[RAW_TransactionData_20200209]
*/
