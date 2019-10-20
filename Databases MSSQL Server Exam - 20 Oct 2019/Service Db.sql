CREATE DATABASE [Service]

USE [Service]

CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(50) NOT NULL,
	[Name] VARCHAR(50),
	Birthdate DATETIME2,
	Age INT,
	CONSTRAINT Check_Age
	CHECK(Age>=14 AND Age<=110),
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	Birthdate DATETIME2,
	Age INT,
	CONSTRAINT Check_EmpAge
	CHECK(Age>=18 AND Age<=110),
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id)
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL
)

CREATE TABLE [Status](
	Id INT PRIMARY KEY IDENTITY,
	Label VARCHAR(30) NOT NULL
)

CREATE TABLE Reports(
	Id INT PRIMARY KEY IDENTITY,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	StatusId INT FOREIGN KEY REFERENCES [Status](Id) NOT NULL,
	OpenDate DATETIME2 NOT NULL,
	CloseDate DATETIME2,
	[Description] VARCHAR(200) NOT NULL,
	UserId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id)
)

-- Exercise 2
INSERT INTO Employees (FirstName, LastName, Birthdate, DepartmentId) VALUES
	('Marlo',	'O''Malley',	'1958-9-21',	1),
('Niki',	'Stanaghan',	'1969-11-26',	4),
('Ayrton',	'Senna',	'1960-03-21',	9),
('Ronnie',	'Peterson',	'1944-02-14',	9),
('Giovanna',	'Amati',	'1959-07-20',	5)

INSERT INTO Reports (CategoryId, StatusId, OpenDate, CloseDate, [Description], UserId, EmployeeId) VALUES
	(1, 1, '2017-04-13', NULL, 'Stuck Road on Str.133', 6, 2),
	(6,3, '2015-09-05', '2015-12-06', 'Charity trail running', 3, 5),
	(14, 2, '2015-09-07', NULL, 'Falling bricks on Str.58', 5, 2),
	(4, 3, '2017-07-03', '2017-07-06', 'Cut off streetlight on Str.11', 1, 1)
	
-- Exercise 3
UPDATE Reports
SET CloseDate = GETDATE()
WHERE CloseDate IS NULL

SELECT * FROM Reports


-- Exercise 4
DELETE FROM Reports
WHERE StatusId = 4

-- Exercise 5
  SELECT [Description], FORMAT(OpenDate, 'dd-MM-yyyy') AS [Open Date]
    FROM Reports
   WHERE EmployeeId IS NULL
ORDER BY OpenDate, [Description]

-- Exercise 6
SELECT r.[Description], c.[Name]
  FROM Reports r
  JOIN Categories c ON r.CategoryId = c.Id
ORDER BY r.[Description], c.[Name]

-- Exercise 7
  SELECT TOP(5) c.[Name] AS [CategoryName], COUNT(r.CategoryId) AS [ReportsNumber]
    FROM Reports r
    JOIN Categories c ON r.CategoryId = c.Id
GROUP BY r.CategoryId, c.[Name]
ORDER BY ReportsNumber DESC, c.[Name]

-- Exercise 8
SELECT u.Username, c.[Name]
  FROM Reports r
  JOIN Users u ON r.UserId = u.Id
  JOIN Categories c ON r.CategoryId = c.Id
 WHERE DAY(u.Birthdate) = DAY(r.OpenDate) AND MONTH(u.Birthdate) = MONTH(r.OpenDate)
ORDER BY u.Username, c.[Name]

SELECT * FROM Reports
SELECT * FROM Users  

-- Exercise 9
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS [FullName], COUNT(r.UserId) AS [UsersCount]
FROM Employees e
LEFT JOIN Reports r ON e.Id = r.EmployeeId
LEFT JOIN Users u ON r.UserId = u.Id
GROUP BY e.FirstName, e.LastName
ORDER BY UsersCount DESC, FullName

-- Exercise 10
SELECT CASE
		WHEN e.FirstName IS NULL AND e.LastName IS NULL THEN 'None'
		ELSE CONCAT(e.FirstName, ' ', e.LastName)
		END AS [Employee],
		CASE 
		  WHEN d.[Name] IS NULL THEN 'None'
		  ELSE d.[Name]
		END AS [Department],
	   c.[Name],
	   r.[Description],
	   FORMAT(r.OpenDate, 'dd.MM.yyyy') AS [Open Date],
	   s.[Label],
	   u.[Name]
  FROM Reports r
LEFT JOIN Employees e ON e.Id = r.EmployeeId
LEFT JOIN Departments d ON e.DepartmentId = d.Id
LEFT JOIN Categories c ON r.CategoryId = c.Id
LEFT JOIN [Status] s ON s.Id = r.StatusId
LEFT JOIN Users u ON u.Id = r.UserId
ORDER BY e.FirstName DESC, e.LastName DESC, d.[Name], c.[Name], r.[Description], OpenDate, s.[Label], u.[Name]

-- Exercise 11
CREATE FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT
AS
BEGIN
	IF(@StartDate IS NULL OR @EndDate IS NULL)
	BEGIN
		RETURN 0
	END

	RETURN DATEDIFF(HOUR, @StartDate, @EndDate)
END

SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours
   FROM Reports

-- Exercise 12
CREATE PROCEDURE usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT) 
AS
BEGIN
	DECLARE @empDepId INT = (SELECT TOP(1) DepartmentId FROM Employees WHERE Id = @EmployeeId)
	DECLARE @repDepId INT = (
								SELECT TOP(1) c.DepartmentId
									FROM Reports r
									JOIN Categories c ON r.CategoryId = c.Id
								 WHERE r.Id = @ReportId
							)
	IF(@empDepId <> @repDepId)
	BEGIN
		RAISERROR('Employee doesn''t belong to the appropriate department!', 16, 2) RETURN
	END

	UPDATE Reports 
	SET EmployeeId = @EmployeeId
	WHERE Id = @ReportId

END

EXEC usp_AssignEmployeeToReport 30, 1
EXEC usp_AssignEmployeeToReport 17, 2