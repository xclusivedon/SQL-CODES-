--Window Functions with RANK


--Exercise 1
-- add a derived column called “Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice – within each category 

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   [Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	   [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
	   [Top 5 Price In Category] = 
							CASE 
								WHEN (ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)) <= 5 THEN 'Yes' 
								ELSE 'No'
							END,

		[Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)
		
													
FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID



--Exercise 2
-- adding a derived column called "Category Price Rank With Dense Rank" that uses the DENSE_RANK function to rank all products by ListPrice – within each category 

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   [Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	   [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
	   [Top 5 Price In Category] = 
							CASE 
								WHEN (ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)) <= 5 THEN 'Yes' 
								ELSE 'No'
							END,

		[Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
		[Category Price Rank With Dense Rank] = DENSE_RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)
		
FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID


--Exercise 3
-- adding a derived column to return a true top 5 products by price, assuming we want to see the top 5 distinct prices



SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   [Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	   [Category Price Rank] = ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
	   [Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
	   [Category Price Rank With Dense Rank] = DENSE_RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC),
	   [Top 5 Price In Category_DENSE RANK] = 
							CASE 
								WHEN (DENSE_RANK() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)) <= 5 THEN 'Yes'
								ELSE 'No'
							END
													
FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID