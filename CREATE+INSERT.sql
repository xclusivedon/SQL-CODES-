--Expanding Temp Table using CREATE + INSERT 

CREATE TABLE #Sales
(
	OrderDate DATE,
	OrderMonth DATE,
	TotalDue MONEY,
	OrderRank INT
)


INSERT INTO #Sales
(
	OrderDate,
	OrderMonth,
	TotalDue,
	OrderRank
)

SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	    ,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2022.Sales.SalesOrderHeader

--SELECT * FROM #Sales


CREATE TABLE #SalesMinusTop10
(
	OrderMonth DATE,
	TotalSales MONEY
)

INSERT INTO #SalesMinusTop10
(
	OrderMonth,
	TotalSales
)

SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
FROM #Sales
WHERE OrderRank > 10
GROUP BY OrderMonth
ORDER BY OrderMonth



SELECT * FROM #SalesMinusTop10

CREATE TABLE #Purchases
(
	OrderDate DATE,
	OrderMonth DATE,
	TotalDue MONEY,
	OrderRank INT
)


INSERT INTO #Purchases
(
	OrderDate,
	OrderMonth,
	TotalDue,
	OrderRank
)

SELECT OrderDate
	   ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
	   ,TotalDue
	   ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader

SELECT * FROM #Purchases


CREATE TABLE #PurchasesMinusTop10
(
	OrderMonth DATE,
	TotalPurchases MONEY
)

INSERT INTO #PurchasesMinusTop10
(
	OrderMonth,
	TotalPurchases
)


SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
FROM #Purchases
WHERE OrderRank > 10
GROUP BY OrderMonth

SELECT * FROM #PurchasesMinusTop10 


SELECT A.OrderMonth,
       A.TotalSales,
       B.TotalPurchases
FROM #SalesMinusTop10 A
	 JOIN #PurchasesMinusTop10 B 
		ON A.OrderMonth = B.OrderMonth

ORDER BY 1

DROP TABLE #Sales
DROP TABLE #SalesMinusTop10
 



---CTE CODE

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





