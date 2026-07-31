sqlcmd -S localhost\SQLEXPRESS
USE PCSC
go

ALTER VIEW [dbo].[StockBalance]
AS
SELECT TOP (100) PERCENT Pitems.PID, Pitems.UID, Pitems.BarCode, Pitems.ItemName, Pitems.ItemTypeID, Pitems.Sprice, Pitems.MRP, Pitems.QTY AS Purchase, SOLD.Sale * - 1 AS Sale, ISNULL(Pitems.QTY, 0) + ISNULL(SOLD.Sale, 0) 
                  AS Balance, ItemTypeTB.ItemType, Pitems.Orderby, Pitems.Locked, Pitems.Bprice, Pitems.VAT, Pitems.VATPER, Pitems.Price, Pitems.Pkg, Pitems.Transport, Pitems.ProfitPER, Pitems.Profit, Pitems.others, Pitems.Discount, 
                  Pitems.Bprice * Pitems.QTY AS Amt, Pitems.Price * Pitems.QTY AS Pamt, Pitems.HSN_Code
FROM     Pitems LEFT OUTER JOIN
                  SOLD ON Pitems.PID = SOLD.PID LEFT OUTER JOIN
                  ItemTypeTB ON Pitems.ItemTypeID = ItemTypeTB.ItemTypeID
ORDER BY Pitems.UID, Pitems.PID
GO


USE master
GO
 

-- 1 - Make a backup
BACKUP DATABASE PCSC
TO DISK = 'D:\PCSC\PCSC31052026.Bak'
   WITH FORMAT,
      MEDIANAME = 'SQLServerBackups',
      NAME = 'Full Backup of PCSC31052026';
GO


-- Use master
USE master
GO

-- 2 - Is the backup valid
RESTORE VERIFYONLY
FROM DISK = 'D:\PCSC\PCSC31052026.Bak';
GO

-- 3 - Check the logical / physical file names
RESTORE FILELISTONLY
FROM DISK = 'D:\PCSC\PCSC31052026.Bak';
GO



IF EXISTS(select * from sys.databases where name='PCSC31052026')
DROP DATABASE PCSC31052026
GO

-- 4 - Restore the files change the location and name
RESTORE DATABASE PCSC31052026
   FROM DISK = 'D:\PCSC\PCSC31052026.Bak'
   WITH RECOVERY,
   MOVE 'PCSC' TO 'D:\PCSC\PCSC31052026.mdf', 
   MOVE 'PCSC_log' TO 'D:\PCSC\PCSC31052026_Log.ldf';
GO


use PCSC
GO

TRUNCATE TABLE cashbook
GO
TRUNCATE TABLE dbauditlog
GO
TRUNCATE TABLE demand
GO
TRUNCATE TABLE pitems
GO
TRUNCATE TABLE sitems
GO
TRUNCATE TABLE tb1
GO
TRUNCATE TABLE temp1
GO
TRUNCATE TABLE temp2
GO

use pcsc
go

INSERT INTO CashBook
                      (CBDT, BillNo, BillDt, TransTypeID, Amt, CBAmt, Paytype, MEMID, Name)
VALUES     ('31-MAY-2026', 'OB', '31-MAY-2026', 2, 0, 0, 'CASH', 1, 'STOCK BALANCE')


IF NOT EXISTS(SELECT * FROM sys.columns
WHERE Name = N'OLDID' AND OBJECT_ID = OBJECT_ID(N'Pitems'))
BEGIN
ALTER TABLE dbo.Pitems 
		ADD 	OLDID int NULL
		CONSTRAINT [DF_Pitems_OLDID]  DEFAULT ((0))

END
GO

INSERT INTO PCSC.dbo.Pitems
                         (UID, BarCode, ItemName, ItemTypeID, HSN_Code, Sprice, MRP, QTY, Locked, Bprice, VAT, VATPER, Price, Pkg, Transport, ProfitPER, Profit, Amt, Pamt, others, Discount, OLDID, VAT_A, ItemType)
SELECT        UID, BarCode, ItemName, ItemTypeID, HSN_Code, Sprice, MRP, Balance, Locked, Bprice, VAT, VATPER, Price, Pkg, Transport, ProfitPER, Profit, Bprice * Balance AS AMT, Price * Balance AS PAMT, others, Discount, PID,   VAT * Balance AS VAT_A, ItemType
FROM            PCSC31052026.dbo.StockBalance
WHERE        (Balance > 0)

Go

UPDATE p SET p.[BandName] = [o].[BandName] FROM [PCSC31052026].dbo.[Pitems] p JOIN  [dbo].[Pitems] o ON [o].[pid] = [p].[PID] 
go

UPDATE Pitems SET  Pdt = '31-MAR-2026', CBID = 1, UserID=1
GO

UPDATE Pitems SET Discount = 0 where Discount is NULL
GO

UPDATE Pitems SET CBID = 1
GO

update Pitems set TransTypeID = 2
GO

update Pitems set price= bprice where price is NULL or bprice =0
go
update Pitems set pamt = amt where pamt is NULL or pamt = 0
go
---Credit Balance

DECLARE @dt1 datetime
set @dt1 = '31-MAR-2026'
INSERT INTO CashBook
                        (MEMID, Amt, CrAmt, Name, BillDt, CBDT, BillNo, TransTypeID,  Paytype, PayTypeID)
SELECT        MEMID, Bal_AMT, Bal_AMT AS CrAmt, Name, @dt1, @dt1 , N'BAL' , 6, 'Sale Credit', 2
FROM            PCSC31052026.dbo.MEM_Credit_bal where Bal_AMT<>0 and MEMTYPE	= 'EMP'

INSERT INTO CashBook
                        (MEMID, Amt, CrAmt, Name, BillDt, CBDT, BillNo, TransTypeID,  Paytype, PayTypeID)
SELECT        MEMID, Bal_AMT, Bal_AMT AS CrAmt, Name, @dt1, @dt1 , N'BAL' , 9, 'Purchase Credit', 2
FROM            PCSC31052026.dbo.MEM_Credit_bal where Bal_AMT<>0 and MEMTYPE	= 'SUPPLIER'
GO

ALTER VIEW [dbo].[PurchaseEntry]
AS
SELECT        UID, BarCode, ItemName, ItemType, ItemTypeID
FROM            (SELECT        Pitems.UID, Pitems.BarCode, Pitems.ItemName, ItemTypeTB.ItemType, ItemTypeTB.ItemTypeID
                          FROM            Pitems INNER JOIN
                                                    ItemTypeTB ON Pitems.ItemTypeID = ItemTypeTB.ItemTypeID
                          UNION
                          SELECT        Pitems_1.UID, Pitems_1.BarCode, Pitems_1.ItemName, ItemTypeTB_1.ItemType, ItemTypeTB_1.ItemTypeID
                          FROM            PCSC31052026.dbo.Pitems AS Pitems_1 INNER JOIN
                                                   PCSC31052026.dbo.ItemTypeTB AS ItemTypeTB_1 ON Pitems_1.ItemTypeID = ItemTypeTB_1.ItemTypeID) AS PRUCH
GROUP BY UID, BarCode, ItemName, ItemType, ItemTypeID

GO



select sum(balance*bprice), count(*) from [PCSC31052026].[dbo].[StockBalance] where Balance>0

select sum(amt), count(*)  from [PCSC].[dbo].pitems

select sum(balance*bprice), count(*) from [PCSC].[dbo].[StockBalance] where Balance>0

GO


USE [PCSC]
GO

/****** Object:  Table [dbo].[newGstRate]    Script Date: 25-09-2025 07:03:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.newGstRate', 'U') IS NOT NULL
    DROP TABLE dbo.newGstRate;
GO

CREATE TABLE [dbo].[newGstRate](
    [pid] [int] NOT NULL,
    [newGST] [decimal](18, 2) NULL,
    [brandName]  VARCHAR(100) NULL,
    [OLDGST] [decimal](18, 2) NULL,
 CONSTRAINT [PK_newGstRate] PRIMARY KEY CLUSTERED 
(
    [pid] ASC
)WITH (
    PAD_INDEX = OFF, 
    STATISTICS_NORECOMPUTE = OFF, 
    IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS = ON, 
    ALLOW_PAGE_LOCKS = ON
) ON [PRIMARY]
) ON [PRIMARY];
GO


