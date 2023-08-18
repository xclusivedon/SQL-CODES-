-- Using Common Table Expressions (CTE) to re-write subqueries in a stepwise manner
--Check subquery below this code that was transformed into CTE

WITH Sales AS 
(
SELECT OrderDate,
	   TotalDue,
	   OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
	   OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)	   
FROM AdventureWorks2022.Sales.SalesOrderHeader
),
Top10 AS
(
SELECT OrderMonth,
	   Top10Total = SUM(TotalDue)	   
FROM Sales  		
WHERE OrderRank <= 10
GROUP BY OrderMonth

)
-- SELECT * FROM Top10 (Top 10 is the Final Virtual Table)

SELECT A.OrderMonth,
	   A.Top10Total,
	   PrevTop10Total = B.Top10Total
FROM Top10 A
		LEFT JOIN Top10 B
			ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)
			ORDER BY A.OrderMonth







SELECT A.OrderMonth,
	   A.Top10Total,
	   PrevTop10Total = B.Top10Total
FROM	  
(
		SELECT OrderMonth,
			  Top10Total = SUM(TotalDue)	   
		FROM   
		(
  
			 SELECT OrderDate,
					TotalDue,
					OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
					OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	   
			 FROM AdventureWorks2022.Sales.SalesOrderHeader
		) X
		WHERE OrderRank <= 10
		GROUP BY OrderMonth
		
		
) A

LEFT JOIN

(
		SELECT OrderMonth,
			  Top10Total = SUM(TotalDue)	   
		FROM   
		(
  
			 SELECT OrderDate,
					TotalDue,
					OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
					OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	   
			 FROM AdventureWorks2022.Sales.SalesOrderHeader
		) X
		WHERE OrderRank <= 10
		GROUP BY OrderMonth
) B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)
ORDER BY A.OrderMonth