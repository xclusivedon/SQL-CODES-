--Window Functions with ROW_NUMBER


--Exercise 1
--Perform inner join on three tables "Production.Product table", "Production. ProductSubcategory table" and "Production.ProductCategory table"

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   PriceRank = ROW_NUMBER() OVER(ORDER BY ListPrice DESC)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID




--Exercise 2
--Rank all data in the dataset from the product with the most expensive price to the product with the least price

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   PriceRank = ROW_NUMBER() OVER(ORDER BY ListPrice DESC)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID



--Exercise 3
--Rank all products by ListPrice – within each category - in descending order

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   PriceRank = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	   CategoryPriceRank = ROW_NUMBER() OVER(PARTITION BY C.Name  ORDER BY ListPrice DESC)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
	
	
--Exercise 4
--"Top 5 Price In Category" that returns the string “Yes” if a product has one of the top 5 list prices in its product category, and “No” if it does not

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
							END
													
FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID




	