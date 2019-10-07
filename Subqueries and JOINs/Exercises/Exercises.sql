USE SoftUni

-- Exercise 1
SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText 
    FROM Employees AS e
    JOIN Addresses AS a
      ON e.AddressID = a.AddressID
ORDER BY a.AddressID

-- Exercise 2
SELECT TOP(50) 
	e.FirstName, 
	e.LastName, 
	t.[Name] AS [Town], 
	a.AddressText 
	FROM Employees AS e
		LEFT JOIN Addresses AS a 
	    ON e.AddressID = a.AddressID
	    LEFT JOIN Towns AS t 
	    ON t.TownID = a.TownID 
ORDER BY FirstName, LastName

-- Exercise 3
  SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS [DepartmentName]
    FROM Employees AS e
    JOIN Departments AS d
      ON e.DepartmentID = d.DepartmentID
   WHERE d.[Name] = 'Sales'
ORDER BY e.EmployeeID 

-- Exercise 4
  SELECT TOP(5) EmployeeID, FirstName, Salary, d.[Name] AS [DepartmentName]
    FROM Employees AS e
    JOIN Departments AS d
      ON e.DepartmentID = d.DepartmentID
   WHERE Salary > 15000
ORDER BY e.DepartmentID

-- Exercise 5
  SELECT TOP(3) e.EmployeeID, e.FirstName
    FROM Employees AS e
LEFT JOIN EmployeesProjects AS ep
	  ON ep.EmployeeID = e.EmployeeID
   WHERE ep.ProjectID IS NULL
ORDER BY e.EmployeeID

SELECT * FROM Projects

-- Exercise 6
  SELECT e.FirstName, e.LastName, e.HireDate, d.[Name] AS [DeptName]
    FROM Employees AS e
    JOIN Departments AS d
	  ON e.DepartmentID = d.DepartmentID AND d.[Name] IN ('Sales', 'Finance')
   WHERE e.HireDate > '1/1/1999'
ORDER BY e.HireDate

-- Exercise 7
  SELECT TOP(5) e.EmployeeID, e.FirstName, p.[Name] AS [ProjectName]
    FROM Employees AS e
    JOIN EmployeesProjects AS ep
      ON e.EmployeeID = ep.EmployeeID
    JOIN Projects AS p
      ON p.ProjectID = ep.ProjectID
   WHERE p.EndDate IS NULL AND p.StartDate > '2002-08-13'
ORDER BY e.EmployeeID

SELECT * FROM Projects

-- Exercise 8
SELECT e.EmployeeID,
       e.FirstName, 
	   CASE WHEN p.StartDate >= '2005-01-01' THEN NULL
	   ELSE p.[Name]
	   END AS [ProjectName]
  FROM Employees AS e
  JOIN EmployeesProjects AS ep
    ON e.EmployeeID = ep.EmployeeID AND e.EmployeeID = 24
  JOIN Projects AS p
    ON p.ProjectID = ep.ProjectID

-- instead of case when  IIF(p.StartDate >= '2005-01-01', NULL, p.[Name]) AS [ProjectName]

-- Exercise 9
  SELECT e1.EmployeeID, e1.FirstName, e1.ManagerID, e2.FirstName AS [ManagerName] 
    FROM Employees AS e1
    JOIN Employees AS e2
      ON e1.ManagerID = e2.EmployeeID
   WHERE e2.EmployeeID IN (3, 7)
ORDER BY e1.EmployeeID

-- Exercise 10
  SELECT TOP(50) e1.EmployeeID, 
         CONCAT(e1.FirstName, ' ', e1.LastName) AS [EmployeeName],
		 CONCAT(e2.FirstName, ' ', e2.LastName) AS [ManagerName],
		 d.[Name] AS [DepartmentName]
    FROM Employees AS e1
LEFT JOIN Employees AS e2
	  ON e1.ManagerID = e2.EmployeeID
LEFT JOIN Departments AS d
	  ON d.DepartmentID = e1.DepartmentID
ORDER BY e1.EmployeeID

-- Exercise 11
SELECT MIN(av.[AverageSalary]) AS [MinAverageSalary] 
 FROM(
      SELECT AVG(e.Salary) AS [AverageSalary] 
	    FROM Employees AS e
    GROUP BY DepartmentID ) AS av
	
USE [Geography]

-- Exercise 12
  SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation 
    FROM Peaks AS p
    JOIN Mountains AS m
      ON p.MountainId = m.Id
    JOIN MountainsCountries AS mc
      ON mc.MountainId = m.Id
   WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

-- Exercise 13
  SELECT CountryCode, COUNT(MountainId) AS [MountainRanges]
    FROM MountainsCountries
GROUP BY CountryCode
  HAVING CountryCode IN ('BG', 'RU', 'US')

-- Exercise 14
   SELECT TOP(5) c.CountryName, r.RiverName 
     FROM Countries AS c
FULL JOIN CountriesRivers AS cr
       ON c.CountryCode = cr.CountryCode
FULL JOIN Rivers AS r
       ON r.Id = cr.RiverId
    WHERE c.ContinentCode = 'AF'
 ORDER BY c.CountryName
	 
-- Exercise 15

-- Exercise 16
SELECT COUNT(*) FROM(
   SELECT c.CountryName FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
       ON c.CountryCode = mc.CountryCode
	WHERE mc.MountainId IS NULL) AS dt

-- Exercise 17
   SELECT TOP(5) dt.CountryName, MAX(dt.Elevation), MAX(dt.[Length])
     FROM(
   SELECT c.CountryName, r.[Length], p.Elevation
     FROM Countries c
FULL JOIN MountainsCountries mc
       ON c.CountryCode = mc.CountryCode
FULL JOIN Mountains m
       ON m.Id = mc.MountainId
FULL JOIN Peaks p
       ON p.MountainId = m.Id
FULL JOIN CountriesRivers cr
       ON cr.CountryCode = c.CountryCode
FULL JOIN Rivers r
       ON r.Id = cr.RiverId) AS dt
 GROUP BY dt.CountryName
 ORDER BY MAX(dt.Elevation) DESC, MAX(dt.[Length]) DESC, dt.CountryName

-- Exercise 18
