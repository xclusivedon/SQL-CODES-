SELECT SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
		Ranking = ROW_NUMBER() OVER(PARTITION BY SalesOrderID ORDER BY LineTotal DESC)

FROM AdventureWorks2022.Sales.SalesOrderDetail
ORDER BY SalesOrderID


SELECT SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		--ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
		Ranking = ROW_NUMBER() OVER(ORDER BY LineTotal DESC)

FROM AdventureWorks2022.Sales.SalesOrderDetail
--ORDER BY Ranking 

SELECT SalesOrderID,
		SalesOrderDetailID,
		LineTotal,
		--ProductIDLineTotal = SUM(LineTotal) OVER(PARTITION BY SalesOrderID),
		Ranking = ROW_NUMBER() OVER(ORDER BY LineTotal DESC)

FROM AdventureWorks2022.Sales.SalesOrderDetail
ORDER BY Ranking 

