 --Using multiple subqueries and windows function to identify top 10 sales per month, Top 10 Total sales per month and Comparing current month with previous month sales USING DATEADD AND LEFT JOIN


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

--SECOND VERSION
-- Using window function LAG with GROUP BY


SELECT OrderMonth,
	   Top10total=sum(TotalDue),
	   PrevTop10total=LAG(sum(TotalDue)) Over(Order by OrderMonth)

FROM  (

		SELECT OrderDate,
			   TotalDue,
			   OrderMonth=DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1),
			   OrderRank=ROW_NUMBER() over(partition by DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) order by TotalDue desc)

		FROM AdventureWorks2022.Sales.SalesOrderHeader

      ) X

WHERE OrderRank<=10
GROUP BY OrderMonth

