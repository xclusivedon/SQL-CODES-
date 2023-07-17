--Exercise 1
/* Flattening rows and returning multiple values to a single row in the outer query with a correlated sub-query */
--Removing leading unwanted characters in XML with STUFF fucntion
--Return all products per subcategory 

SELECT A.Name AS SubcategoryName,
	   
	   Products =  STUFF(
					              (
								  SELECT 
						           ';' + Name 
								  FROM AdventureWorks2022.Production.Product B
					              WHERE A.ProductSubcategoryID = B.ProductSubcategoryID
					              FOR XML PATH ('')

					              ),1,1,' '

						)
FROM AdventureWorks2022.Production.ProductSubcategory A


--Exercise 2
/* Flattening rows and returning multiple values to a single row in the outer query with a correlated sub-query */
--Removing leading unwanted characters in XML with STUFF fucntion
--Return all products per subcategory with listPrice greater than 50
SELECT 
       SubcategoryName = A.[Name]
	  ,Products =
		STUFF(
			(
				SELECT
					';' + B.Name

				FROM AdventureWorks2022.Production.Product B

				WHERE A.ProductSubcategoryID = B.ProductSubcategoryID AND B.ListPrice >50

				FOR XML PATH('')

			),1,1,''
		)

  FROM AdventureWorks2022.Production.ProductSubcategory A




