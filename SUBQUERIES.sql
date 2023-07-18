--Exercise 1
/* a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table */

SELECT *

FROM  
	(
		SELECT  PurchaseOrderID,
			VendorID,
		  	OrderDate,
		   	TaxAmt,
		   	Freight,
		   	TotalDue,
		   	[Top3ordersPerVendor] = ROW_NUMBER() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)

			FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader

	) AS V

WHERE [Top3ordersPerVendor] <= 3




--Exercise 2
/* a query that displays the three most expensive orders, per vendor ID, from the Purchasing.PurchaseOrderHeader table 
regardless of how many records are returned per Vendor Id.*/


SELECT *

FROM

	(	SELECT PurchaseOrderID,
	   		VendorID,
	   		OrderDate,
	   		TaxAmt,
	   		Freight,
	   		TotalDue,
	   		[Top3ordersPerVendor] = DENSE_RANK() OVER(PARTITION BY VendorID ORDER BY TotalDue DESC)
           
		FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader
	) AS V

WHERE [Top3ordersPerVendor] <= 3
