--Exercise 1
--Using Recursive CTE to generate an odd number series between 1 and 100

WITH OddSeries AS
(
SELECT 1 AS MyNum

UNION ALL

SELECT MyNum + 2 
FROM OddSeries 
WHERE MyNum < 99
)


SELECT MyNum 
FROM OddSeries 


