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
SELECT FirstName, LastName
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

-- Exercise 11
SELECT * FROM
   (SELECT EmployeeID, FirstName, LastName, Salary, DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
     FROM Employees
    WHERE Salary BETWEEN 10000 AND 50000) AS temp
   WHERE temp.[Rank] = 2
ORDER BY temp.Salary DESC

USE [Geography]
-- Exercise 12
  SELECT CountryName, IsoCode FROM Countries
   WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

-- Exercise 13
  SELECT p.PeakName, r.RiverName, LOWER(CONCAT(LEFT(p.PeakName, LEN(p.PeakName)-1), r.RiverName)) AS [Mix] 
    FROM Peaks AS p, Rivers AS r
   WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY [Mix]

  SELECT p.PeakName, r.RiverName, LOWER(CONCAT(LEFT(p.PeakName, LEN(p.PeakName)-1), r.RiverName)) AS [Mix]  
    FROM Peaks AS p
JOIN Rivers AS r ON RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
ORDER BY [Mix]

USE Diablo
-- Exercise 14
  SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start]
    FROM Games
   WHERE DATEPART([YEAR], [Start]) IN (2011, 2012)
ORDER BY [Start]

-- Exercise 15
  SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email) + 1) 
      AS [Email Provider]
    FROM Users
ORDER BY [Email Provider], Username ASC

-- Exercise 16
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

-- Exercise 17
SELECT [Name] AS [Game],
  CASE 
      WHEN DATEPART(HOUR, Start) BETWEEN 0 AND 11 THEN 'Morning'
      WHEN DATEPART(HOUR, Start) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
  END AS [Part of the day],
  CASE
      WHEN Duration <= 3 THEN 'Extra Short'
	  WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
	  WHEN Duration > 6 THEN 'Long'
	  ELSE 'Extra Long'
  END AS [Duration]
  FROM Games
ORDER BY [Name], [Duration], [Part of the day]

USE Orders

-- Exercise 18
SELECT ProductName, OrderDate, 
       DATEADD(DAY, 3, OrderDate) AS [Pay Due],
	   DATEADD(MONTH, 1, OrderDate) AS [Delivery Due]
  FROM Orders

-- Exercise 19
CREATE TABLE People(
    Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100),
	Birthdate DATETIME
)

INSERT INTO People ([Name], Birthdate) 
VALUES ('Victor', '2000-12-07' ),
       ('Steven', '1992-09-10'),
	   ('Stephen', '1910-09-19 '),
	   ('John', '2010-01-06 ')

SELECT [Name], 
       DATEDIFF(YEAR, Birthdate, GETDATE()) AS [Age in Years],
	   DATEDIFF(MONTH, Birthdate, GETDATE()) AS [Age in Months],
	   DATEDIFF(DAY, Birthdate, GETDATE()) AS [Age in Days],
	   DATEDIFF(MINUTE, Birthdate, GETDATE()) AS [Age in Minutess]
  FROM People
