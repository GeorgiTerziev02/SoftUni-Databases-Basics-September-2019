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
