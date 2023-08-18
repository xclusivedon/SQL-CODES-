--Recursive CTE to generate a date series of all FIRST days of the month (1/1/2021, 2/1/2021, etc.)

WITH DateSerial AS
(
SELECT CAST('2020-01-01' AS DATE) AS MyDate

UNION ALL

SELECT 
DATEADD(MONTH,1,MyDate) 
FROM  DateSerial
WHERE MyDate < CAST('2029-12-01' AS DATE)

)


SELECT 
MyDate
FROM  DateSerial
OPTION(MAXRECURSION 120)