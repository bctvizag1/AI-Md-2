ALTER PROCEDURE [dbo].[StockBalason]
  @tdt datetime,
  @cateenID int = 1
AS
BEGIN

    SELECT     Pitems.UID, Pitems.ItemName, Pitems.Bprice, bal.BAL,(Pitems.Bprice * bal.BAL) AS BALAMT, ItemTypeTB.ItemType, 
    Pitems.Sprice, Pitems.MRP, [Pitems].[VATPER] AS TaxPer, Pitems.HSN_Code,  Pitems.PID, Pitems.BandName, Pitems.expiredDt
    into #t1
    FROM         Pitems INNER JOIN
                          ItemTypeTB ON Pitems.ItemTypeID = ItemTypeTB.ItemTypeID RIGHT OUTER JOIN
                              (SELECT     PID, SUM(QTY * Transvalue) AS BAL
                                FROM          STOCKREGIST
                                WHERE      (dbo.Mydate(BillDt) <= @tdt) AND (@cateenID <= 0 OR CanteenID = @cateenID)
                                GROUP BY PID
                                HAVING      (Not SUM(QTY * Transvalue) = 0)) AS bal ON Pitems.PID = bal.PID
    ORDER BY dbo.udf_VAL(UID)
    --Table 0
    SELECT *, (BALAMT -  dbo.[GST](BALAMT, TaxPer))/ BAL  BasePrice,  BALAMT -  dbo.[GST](BALAMT, TaxPer) T_Base_Amt FROM #t1
    --Table 1
    SELECT      ItemType, SUM(BALAMT) AS Stock_Value, SUM(Sprice*BAL) as [Sale Value],   SUM(Sprice*BAL) - SUM(BALAMT) AS [Expt Porfit] 
    FROM #t1 GROUP BY ItemType
    --Table 2
    SELECT      ItemType, TaxPer,
    SUM(BALAMT) AS Stock_Value, SUM(Sprice*BAL) as [Sale Value],   SUM(Sprice*BAL) - SUM(BALAMT) AS [Expt Porfit] 
    FROM #t1 GROUP BY ItemType, TaxPer
    --Table 3
    SELECT      ItemType, TaxPer,
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS CGST, 
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS SGST, 
        CASE WHEN LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer) ELSE 0 END AS IGST, 
        SUM(BALAMT) AS BalAmt
    FROM #t1 GROUP BY ItemType, TaxPer

    ---Table 4
    SELECT      ItemType, TaxPer, HSN_Code,
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS CGST, 
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS SGST, 
        CASE WHEN LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer) ELSE 0 END AS IGST, 
        SUM(BALAMT) AS BalAmt
    FROM #t1 GROUP BY ItemType, TaxPer, HSN_Code

    --Table 5
        SELECT   ItemName, ItemType, SUM(BAL) AS QTY, Bprice,  TaxPer AS [GST Rate], HSN_Code, 
        SUM(BALAMT) - dbo.[GST](SUM(BALAMT), TaxPer) AS [Taxable Value],
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS CGST, 
        CASE WHEN Not LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer)/2 ELSE 0 END AS SGST, 
        CASE WHEN LEFT(ItemType,4) = 'IGST' THEN  dbo.[GST](SUM(BALAMT), TaxPer) ELSE 0 END AS IGST, 
        SUM(BALAMT) AS [TotalAmt]
    FROM #t1 GROUP BY ItemName, TaxPer, Bprice, HSN_Code, ItemType

         --Table 6
    SELECT  UID, ItemName, Bprice, SUM(BAL) BAL,SUM(BALAMT) BALAMT, ItemType, 
    Sprice, MRP, TaxPer, HSN_Code FROM #t1 
    GROUP BY UID, ItemName, Bprice,  ItemType, Sprice, MRP, TaxPer, HSN_Code


End



