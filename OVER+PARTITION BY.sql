--Window Functions With OVER and PARTITION BY


--Exercise 1
--Perform inner join on three tables "Production.Product table", "Production. ProductSubcategory table" and "Production.ProductCategory table"

SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID


--Exercise 2
--adding a derived column called "AvgPriceByCategory" that returns the average ListPrice for the product category in each given row.
SELECT A.Name AS ProductName,
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   AvgPriceByCategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
--ORDER BY C.Name DESC


--Exercise 3
--adding a derived column called "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.

SELECT A.Name AS ProductName,
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   AvgPriceByCategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name),
	   AvgPriceByCategoryAndSubcategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name,B.Name)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
--ORDER BY B.Name,C.Name DESC


--Exercise 4
--adding a derived column called "AvgPriceByCategory" that returns the average ListPrice for the product category in each given row.
SELECT A.Name AS ProductName,
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   AvgPriceByCategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name),
	   AvgPriceByCategoryAndSubcategory = AVG(A.ListPrice) OVER(PARTITION BY C.Name,B.Name),
	   ProductVsCategoryDelta = A.ListPrice - AVG(A.ListPrice) OVER(PARTITION BY C.Name)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
--ORDER BY B.Name,C.Name DESC




/* Code Snippet for Comparing GROUP BY with PARTITION BY to ensure accuracy
---------------
*/
--Case Study - Exercise 2
--adding a derived column called "AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
SELECT A.Name AS "ProductName",
	   A.ListPrice,
	   B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   AvgPriceByCategory = AVG(ListPrice) OVER(PARTITION BY C.Name)

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
--ORDER BY C.Name DESC


SELECT --A.Name AS ProductName,
	   --A.ListPrice,
	  -- B.Name AS ProductSubCategory,
	   C.Name AS ProductCategory,
	   AVG(ListPrice) AS  AvgPriceByCategory

FROM AdventureWorks2022.Production.Product AS A
	INNER JOIN AdventureWorks2022.Production.ProductSubcategory AS B
		ON A.ProductSubcategoryID = B.ProductSubcategoryID
	INNER JOIN AdventureWorks2022.Production.ProductCategory AS C
		ON B.ProductCategoryID = C.ProductCategoryID
GROUP BY --A.Name,
	     --A.ListPrice,
	     --B.Name,
	     C.Name 
















