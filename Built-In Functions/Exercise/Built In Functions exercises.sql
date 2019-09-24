USE SoftUni

-- Exercise 1
SELECT FirstName, LastName
  FROM Employees
 WHERE FirstName LIKE 'SA%'

-- Exercise 2
SELECT FirstName, LastName
  FROM Employees
 WHERE LastName LIKE '%ei%'

-- Exercise 3
SELECT FirstName 
  FROM Employees
 WHERE DepartmentID IN (3,10) AND CAST(DATEPART(Year, HireDate) AS INT) BETWEEN 1995 AND 2005

 -- Exercise 4
SELECT FirstName, LastNamek
  FROM Employees
 WHERE JobTitle NOT LIKE '%engineer%'  

-- Exercise 5
  SELECT [Name] 
    FROM Towns
   WHERE LEN([Name]) IN (5, 6)
ORDER BY [Name]

-- Exercise 6
  SELECT TownID, [Name]
    FROM Towns
   WHERE [Name] LIKE '[M,K,B,E]%'
ORDER BY [Name]

-- Exercise 7
  SELECT TownID, [Name]
    FROM Towns
   WHERE [Name] NOT LIKE '[R,B,D]%'
ORDER BY [Name]

-- Exercise 8
GO
CREATE VIEW V_EmployeesHiredAfter2000
         AS
     SELECT FirstName, LastName
       FROM Employees
	  WHERE CAST(DATEPART(YEAR, HireDate) AS INT) > 2000
GO

-- Exercise 9
SELECT FirstName, LastName
  FROM Employees
 WHERE LEN(LastName) = 5

-- Exercise 10
  SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
    FROM Employees
   WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC