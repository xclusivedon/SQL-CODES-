--Subquery Code used to convert to CTE is located beneath this code

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





SELECT
A.OrderMonth,
A.TotalSales,
B.TotalPurchases

FROM (
	SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2022.Sales.SalesOrderHeader
		) S
	WHERE OrderRank > 10
	GROUP BY OrderMonth
) A

JOIN (
	SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader
		) P
	WHERE OrderRank > 10
	GROUP BY OrderMonth
) B	ON A.OrderMonth = B.OrderMonth

ORDER BY 1
















