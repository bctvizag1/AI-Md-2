USE TPT
go

IF OBJECT_ID('TPT.dbo.tempdb', 'U') IS NOT NULL
BEGIN
    DROP TABLE TPT.dbo.tempdb
END;
go

IF OBJECT_ID('PCSC.dbo.tempCB', 'U') IS NOT NULL
BEGIN
    DROP TABLE PCSC.dbo.tempCB
END;
go


declare @cbid  int;

--select * from tpt.dbo.CashBook where TransTypeID = 1 and MEMID = 23388

set @cbid = (select max(cbid) from TPT.dbo.CashBook where TransTypeID = 1 and MEMID = 23388);



WITH si AS ( 
SELECT * FROM TPT.dbo.Sitems s WHERE s.CBID = @cbid
) SELECT p.* INTO TPT.dbo.tempdb from TPT.dbo.Pitems p JOIN si ON p.PID = si.PID  




UPDATE t SET QTY = s.QTY FROM TPT.dbo.tempdb t JOIN TPT.dbo.Sitems s ON t.PID = s.PID WHERE s.cbid = @cbid;

--select * from tempdb


UPDATE TPT.dbo.tempdb SET Price = Sprice, Bprice = Sprice, ProfitPER = 0, Profit = 0

UPDATE TPT.dbo.tempdb SET Pamt = Price * QTY, Amt = Bprice * QTY, VAT_A = VAT * QTY, CBID = 0;

--SELECT SUM(amt), COUNT(qty), SUM([Bprice] * QTY) FROM [tempdb] 

--SELECT SUM(amt) FROM tempdb t
--SELECT *  FROM tempdb t
/*
use PCSC
go

*/

select * into PCSC.dbo.tempCB from  tpt.dbo.CashBook where cbid =  @cbid
go

BEGIN
ALTER TABLE  TPT.dbo.tempdb
	DROP COLUMN PID   
END
go

BEGIN
ALTER TABLE  PCSC.dbo.tempCB
	DROP COLUMN cbid
END
go

INSERT INTO PCSC.dbo.CashBook (CBDT, BillNo, BillDt, TransTypeID, HA, Amt, CBAmt, CrAmt, Bank, Paytype, MEMID, Name, UserID, dateStamp, Refdetails, Refdetails1, Remarks, Wallet, PayTypeID, Bank_SC, GSTREBATE, PAYABLEAMT, discount, 
                         discPER)
SELECT        CBDT, BillNo, BillDt, TransTypeID, HA, Amt, CBAmt, CrAmt, Bank, Paytype, MEMID, Name, UserID, dateStamp, Refdetails, Refdetails1, Remarks, Wallet, PayTypeID, Bank_SC, GSTREBATE, PAYABLEAMT, discount, 
                         discPER
FROM            PCSC.dbo.tempCB
go


update TPT.dbo.tempdb set Bprice = Sprice, CBID = (Select MAX(CBID) from PCSC.dbo.CashBook where TransTypeID = 1)
go


insert into PCSC.dbo.Pitems select * from  TPT.dbo.tempdb
go


WITH LastRow AS (
    SELECT TOP 1 *
    FROM PCSC.dbo.CashBook
    ORDER BY CBID DESC 
)
UPDATE LastRow SET TransTypeID = 2 
go




/*


use TPT
go

select * from CashBook 
	where TransTypeID = 1 and MEMID = 23388
	order by cbid desc
*/