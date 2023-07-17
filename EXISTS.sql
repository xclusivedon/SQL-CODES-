--Exercise 1
/* Select all records from the Purchasing.PurchaseOrderHeader table such that there is at least one item in the order with an order quantity greater than 500 */

SELECT PurchaseOrderID,
		OrderDate,
		SubTotal,
		TaxAmt
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader A
WHERE EXISTS (
				SELECT 
				1
				FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail B
				WHERE A.PurchaseOrderID = B.PurchaseOrderID AND OrderQty > 500
			 )

ORDER BY PurchaseOrderID



--Exercise 2
/* Select all records from the Purchasing.PurchaseOrderHeader table such that there is at 
least one item in the order with an order quantity greater than 500, AND a unit price greater than $50.00.*/ 

SELECT A.*
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader A
WHERE EXISTS (
				SELECT 
				1
				FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail B
				WHERE A.PurchaseOrderID = B.PurchaseOrderID AND OrderQty > 500 AND UnitPrice > 50
			 )

ORDER BY PurchaseOrderID



				




--Exercise 3
/* Select all records from the Purchasing.PurchaseOrderHeader table such that NONE of the items within the order have a rejected quantity greater than 0 */

SELECT *
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader A
WHERE NOT EXISTS (
				SELECT 
				1
				FROM AdventureWorks2022.Purchasing.PurchaseOrderDetail B
				WHERE A.PurchaseOrderID = B.PurchaseOrderID AND RejectedQty > 0
			 )

ORDER BY PurchaseOrderID



				