--Exercise 1
/* Correlated subquery to add a derived column called NonRejectedItems which returns, 
for each purchase order ID in the query output, the number of line items from the Purchasing.PurchaseOrderDetail table which did not have any rejections */

SELECT PurchaseOrderID,
		VendorID,
		OrderDate,
		TotalDue,
		NonRejectedItems = (
							SELECT COUNT(*)
							FROM Purchasing.PurchaseOrderDetail B
							WHERE A.PurchaseOrderID = B.PurchaseOrderID 
							AND RejectedQty = 0
						   )
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader A


--Exercise 2
/* to include a second derived field called MostExpensiveItem.
which return, for each purchase order ID, the UnitPrice of the most expensive item for that order in the Purchasing.PurchaseOrderDetail table */

SELECT PurchaseOrderID,
		VendorID,
		OrderDate,
		TotalDue,
		NonRejectedItems = (
							SELECT COUNT(*)
							FROM Purchasing.PurchaseOrderDetail B
							WHERE A.PurchaseOrderID = B.PurchaseOrderID 
							AND RejectedQty = 0
						   ),
		MostExpensiveItem = (
								SELECT MAX(UnitPrice) 
								FROM Purchasing.PurchaseOrderDetail B
								WHERE A.PurchaseOrderID = B.PurchaseOrderID 
								
							)
FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader A



