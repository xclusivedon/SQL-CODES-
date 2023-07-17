--Window Functions With OVER
--Exercise 1

SELECT FirstName,
	   LastName,
	   rate,
	   [AverageRate] = AVG(rate) OVER()
FROM AdventureWorks2022.Person.Person 
	INNER JOIN AdventureWorks2022.HumanResources.Employee
			ON Person.BusinessEntityID = Employee.BusinessEntityID
	INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory
			ON Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID



--Exercise 2

SELECT FirstName,
	   LastName,
	   rate,
	   [AverageRate] = AVG(rate) OVER(),
	   [MaximumRate] = MAX(rate) OVER()
FROM AdventureWorks2022.Person.Person 
	INNER JOIN AdventureWorks2022.HumanResources.Employee
			ON Person.BusinessEntityID = Employee.BusinessEntityID
	INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory
			ON Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID


--Exercise 3

SELECT FirstName,
	   LastName,
	   rate,
	   [AverageRate] = AVG(rate) OVER(),
	   [MaximumRate] = MAX(rate) OVER(),
	   [DiffFromAvgRate] = [rate] - AVG(rate) OVER()
FROM AdventureWorks2022.Person.Person 
	INNER JOIN AdventureWorks2022.HumanResources.Employee
			ON Person.BusinessEntityID = Employee.BusinessEntityID
	INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory
			ON Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID



--Exercise 4

SELECT FirstName,
	   LastName,
	   rate,
	   [AverageRate] = AVG(rate) OVER(),
	   [MaximumRate] = MAX(rate) OVER(),
	   [DiffFromAvgRate] = [rate] - AVG(rate) OVER(),
	   [PercentOfMaxRate] = ([rate] / MAX(rate) OVER()) * 100
FROM AdventureWorks2022.Person.Person 
	INNER JOIN AdventureWorks2022.HumanResources.Employee
			ON Person.BusinessEntityID = Employee.BusinessEntityID
	INNER JOIN AdventureWorks2022.HumanResources.EmployeePayHistory
			ON Person.BusinessEntityID = EmployeePayHistory.BusinessEntityID

