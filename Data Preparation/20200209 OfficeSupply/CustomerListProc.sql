USE [DSTRAIN]
GO
/****** Object:  StoredProcedure [dbo].[BLD_WRK_CustomerList]    Script Date: 2/10/2020 4:00:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[BLD_WRK_CustomerList]
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
if object_id('WRK_CustomerList') is not null
drop table [WRK_CustomerList]

-- =============================================
-- Create Table
-- =============================================
create table [WRK_CustomerList](
	[RowNumber]		int identity(1,1)
	,[Customer ID]	varchar(100)
	,[City]			varchar(1000)
	,[ZipCode]		varchar(5)
	,[Gender]		varchar(1)
	,[Age]			float
)

-- =============================================
-- Truncate Table
-- =============================================
truncate table [WRK_CustomerList]

-- =============================================
-- Insert Into
-- =============================================
insert into [WRK_CustomerList](
	[Customer ID]
	,[City]
	,[ZipCode]
	,[Gender]
	,[Age]
)
select right('0000000'+[Customer ID],7)
	,[City]
	,[ZipCode]
	,[Gender]
	,[Age]
from [dbo].[RAW_CustomerList_20200209]
--(43 rows affected)

END

/*
	select * from [dbo].[RAW_CustomerList_20200209]
*/
