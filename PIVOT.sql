--Exercise 1
/*PIVOT query against the HumanResources.Employee table
that summarizes the average amount of vacation time for Sales Representatives, Buyers, and Janitors */

SELECT *
FROM

(
SELECT JobTitle,
	   VacationHours
FROM AdventureWorks2022.HumanResources.Employee
WHERE JobTitle IN ('Sales Representative','Buyer','Janitor')

) B

PIVOT
(
AVG(VacationHours)
FOR JobTitle IN  ([Sales Representative],[Buyer],[Janitor])
) C




--Exercise 2
/*PIVOT query against the HumanResources.Employee table
that summarizes the average amount of vacation time for Sales Representatives, Buyers, and Janitors by GENDER */

SELECT *
FROM

(
SELECT [Employee Gender] = Gender,
	   JobTitle,
	   VacationHours
FROM AdventureWorks2022.HumanResources.Employee
WHERE JobTitle IN ('Sales Representative','Buyer','Janitor')

) B

PIVOT
(
AVG(VacationHours)
FOR JobTitle IN  ([Sales Representative],[Buyer],[Janitor])
) C

