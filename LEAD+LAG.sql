--Window Functions with LEAD and LAG

--Exercise 1
--Create a query with the following columns:


SELECT     A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   B.Name AS "VendorName"

FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader AS A
	INNER JOIN AdventureWorks2022.Purchasing.Vendor AS B
		ON A.VendorID = B.BusinessEntityID

WHERE  YEAR(A.OrderDate) >= 2013 AND A.TotalDue > 500





--Exercise 2
/*Adding a derived column called "PrevOrderFromVendorAmt", 
that returns the “previous” TotalDue value (relative to the current row) within the group of all orders with the same vendor ID. */

SELECT A.PurchaseOrderID,
	   A.OrderDate,
	   B.Name AS "VendorName",
	   A.TotalDue,
	   [PrevOrderFromVendorAmt] = LAG(A.TotalDue,1) OVER(PARTITION BY  A.VendorID ORDER BY A.OrderDate)

FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader AS A
	INNER JOIN AdventureWorks2022.Purchasing.Vendor AS B
		ON A.VendorID = B.BusinessEntityID

WHERE  YEAR(A.OrderDate) >= 2013 AND A.TotalDue > 500



--Exercise 3
/* Adding a derived column called "NextOrderByEmployeeVendor", 
that returns the “next” vendor name (the “name” field from Purchasing.Vendor) within the group of all orders that have the same EmployeeID value. */

SELECT     A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   [PrevOrderFromVendorAmt] = LAG(A.TotalDue,1) OVER(PARTITION BY  A.VendorID ORDER BY A.OrderDate),
	   B.Name AS "VendorName",
	   [NextOrderByEmployeeVendor] = LEAD(B.Name,1) OVER(PARTITION BY  A.EmployeeID ORDER BY A.OrderDate)

FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader AS A
	INNER JOIN AdventureWorks2022.Purchasing.Vendor AS B
		ON A.VendorID = B.BusinessEntityID

WHERE  YEAR(A.OrderDate) >= 2013 AND A.TotalDue > 500



--Exercise 4
/* Adding a derived column called "Next2OrderByEmployeeVendor" 
that returns, within the group of all orders that have the same EmployeeID, the vendor name offset TWO orders into the “future” relative to the order in the current row */

SELECT     A.PurchaseOrderID,
	   A.OrderDate,
	   A.TotalDue,
	   [PrevOrderFromVendorAmt] = LAG(A.TotalDue,1) OVER(PARTITION BY  A.VendorID ORDER BY A.OrderDate),
	   B.Name AS "VendorName",
	   [NextOrderByEmployeeVendor] = LEAD(B.Name,1) OVER(PARTITION BY  A.EmployeeID ORDER BY A.OrderDate),
	   [Next2OrderByEmployeeVendor] = LEAD(B.Name,2) OVER(PARTITION BY  A.EmployeeID ORDER BY A.OrderDate)

FROM AdventureWorks2022.Purchasing.PurchaseOrderHeader AS A
	INNER JOIN AdventureWorks2022.Purchasing.Vendor AS B
		ON A.VendorID = B.BusinessEntityID

WHERE  YEAR(A.OrderDate) >= 2013 AND A.TotalDue > 500

