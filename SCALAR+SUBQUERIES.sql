--Exercise 1
/* Adding a derived column called "MaxVacationHours" by the use of a subquery that returns the maximum amount of vacation hours for any one employee, in any given row.*/

SELECT     BusinessEntityID,
	   JobTitle,
           VacationHours,
	   [MaxVacationHours] = (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee)

FROM AdventureWorks2022.HumanResources.Employee


--Exercise 2
/* Returns the percent an individual employees' vacation hours of the maximum vacation hours for any employee */

SELECT     BusinessEntityID,
	   JobTitle,
          VacationHours,
	   [MaxVacationHours] = (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee),
	   [PercentVacationHours] =  (1.0 * VacationHours) / (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee)

FROM AdventureWorks2022.HumanResources.Employee



--Exercise 3
/* Refine your output with a criterion in the WHERE clause 
that filters out any employees whose vacation hours are less then 80% of the maximum amount of vacation hours */

SELECT     BusinessEntityID,
	   JobTitle,
           VacationHours,
	   [MaxVacationHours] = (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee),
	   [PercentVacationHours] =  (1.0 * VacationHours) / (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee)
	   
FROM AdventureWorks2022.HumanResources.Employee

WHERE VacationHours >=  0.8 * (SELECT MAX(VacationHours) FROM AdventureWorks2022.HumanResources.Employee)
