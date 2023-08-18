--CTE Code used to convert to Temp Table is located beneath this code

SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	    ,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
INTO #Sales
FROM AdventureWorks2022.Sales.SalesOrderHeader



SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
INTO #SalesMinusTop10
FROM #Sales
WHERE OrderRank > 10
GROUP BY OrderMonth

--SELECT * FROM SalesMinusTop10 A 


SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	   ,TotalDue
	   ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
INTO #Purchases
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader


SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
INTO #PurchasesMinusTop10
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

--SELECT * FROM PurchasesMinusTop10 B

SELECT A.OrderMonth,
       A.TotalSales,
       B.TotalPurchases
FROM #SalesMinusTop10 A
	 JOIN #PurchasesMinusTop10 B 
		ON A.OrderMonth = B.OrderMonth

ORDER BY 1

DROP TABLE #Sales
DROP TABLE #SalesMinusTop10
 





WITH Sales AS
(
SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	    ,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2022.Sales.SalesOrderHeader
),
SalesMinusTop10 AS
(
SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
	FROM Sales
	WHERE OrderRank > 10
	GROUP BY OrderMonth
),
--SELECT * FROM SalesMinusTop10 A 

Purchases AS 
(
SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	   ,TotalDue
	   ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	    FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader
),
PurchasesMinusTop10 AS
(
SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
	FROM Purchases
	WHERE OrderRank > 10
	GROUP BY OrderMonth
)
--SELECT * FROM PurchasesMinusTop10 B

SELECT A.OrderMonth,
       A.TotalSales,
       B.TotalPurchases
FROM SalesMinusTop10 A
	 JOIN PurchasesMinusTop10 B 
		ON A.OrderMonth = B.OrderMonth

ORDER BY 1





