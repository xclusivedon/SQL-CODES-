--Re-using Temp Table for Sales and Purchases using CREATE + INSERT 


------- Insert Sales Data
CREATE TABLE #Orders
(
	OrderDate DATE,
	OrderMonth DATE,
	TotalDue MONEY,
	OrderRank INT
)


INSERT INTO #Orders
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

--SELECT * FROM #Orders

------- Extract Sales Data from #Orders with OrderRank > 10 and Insert Sales Data into #OrderMinusTop10 table

CREATE TABLE #OrderMinusTop10
(
	OrderMonth DATE,
	OrderType VARCHAR(32),
	TotalDue MONEY
)

INSERT INTO #OrderMinusTop10
(
	OrderMonth,
	OrderType,
	TotalDue
)

SELECT
	OrderMonth,
	OrderType = 'Sales',
	TotalDue = SUM(TotalDue)
FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth



--SELECT * FROM #OrderMinusTop10



------- Clear Sales Data from #Orders to re-use temp tale for Purchase Data.
--TRUNCATE TABLE #Orders


------- Insert Purchases Data
INSERT INTO #Orders
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

--SELECT * FROM #Orders


------- Append Purchases data to Sales Data in #OrderMinusTop10
INSERT INTO #OrderMinusTop10
(
	OrderMonth,
	OrderType,
	TotalDue
)

SELECT
	OrderMonth,
	OrderType = 'Purchases',
	TotalDue = SUM(TotalDue)
FROM #Orders
WHERE OrderRank > 10
GROUP BY OrderMonth

--SELECT * FROM #OrderMinusTop10

SELECT
A.OrderMonth,
TotalSales = A.TotalDue,
TotalPurchases = B.TotalDue

FROM #OrderMinusTop10 A
	JOIN #OrderMinusTop10 B
		ON A.OrderMonth = B.OrderMonth
			AND B.OrderType = 'Purchase'

WHERE A.OrderType = 'Sales'

ORDER BY 1

DROP TABLE #Orders
DROP TABLE #OrderMinusTop10









