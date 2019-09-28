USE SoftUni

SELECT e.DepartmentID, SUM(e.Salary) AS Salary
  FROM Employees e
GROUP BY e.DepartmentID

SELECT e.DepartmentID, SUM(e.Salary) AS Salary, MAX(e.Salary) AS [Max]
  FROM Employees e
GROUP BY e.DepartmentID
ORDER BY Salary

SELECT e.DepartmentID, Count(e.DepartmentID) AS Employees
  FROM Employees e
GROUP BY e.DepartmentID

SELECT e.FirstName + ' ' + e.LastName AS [Full Name], d.[Name] AS [Department], a.AddressText
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
JOIN Addresses a
ON e.AddressID = a.AddressID

SELECT
    e.DepartmentID,
	COUNT(e.DepartmentID) AS [Total Employees],
	AVG(e.Salary) AS [AvgSalary],
	MAX(e.Salary) AS [MaxSalary],
    MIN(e.Salary) AS [MinSalary],
	SUM(e.Salary) AS [TotalSalary],
	STRING_AGG(e.FirstName + ' ' + e.LastName, ', ') AS [Employees]
FROM Employees e
GROUP BY e.DepartmentID 

SELECT
    e.DepartmentID,
	COUNT(e.DepartmentID) AS [Total Employees],
	AVG(e.Salary) AS [AvgSalary],
	MAX(e.Salary) AS [MaxSalary],
    MIN(e.Salary) AS [MinSalary],
	SUM(e.Salary) AS [TotalSalary],
	STRING_AGG(e.FirstName + ' ' + e.LastName, ', ') AS [Employees]
FROM Employees e
GROUP BY e.DepartmentID
HAVING SUM(e.Salary) > 200000