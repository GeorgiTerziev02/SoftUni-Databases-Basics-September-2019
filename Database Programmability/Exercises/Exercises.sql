USE SoftUni

-- Exercise 1
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
AS
BEGIN
	SELECT e.FirstName, e.LastName
	  FROM Employees AS e
	 WHERE Salary > 35000
END

EXEC usp_GetEmployeesSalaryAbove35000

-- Exercise 2
CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@minSalary DECIMAL(18,4))
AS
BEGIN
	SELECT e.FirstName, e.LastName
	  FROM Employees AS e
	 WHERE e.Salary >= @minSalary
END

EXEC usp_GetEmployeesSalaryAboveNumber 48100

-- Exercise 3
CREATE PROCEDURE usp_GetTownsStartingWith (@start VARCHAR(50))
AS
BEGIN
	SELECT t.[Name]
	  FROM Towns AS t
	 WHERE CHARINDEX(@start, t.[Name]) = 1	 
END

EXEC dbo.usp_GetTownsStartingWith b

-- diff
CREATE PROCEDURE usp_GetTownsStartingWith2 (@start VARCHAR(50))
AS
BEGIN
	SELECT t.[Name]
	  FROM Towns AS t
	 WHERE LEFT(t.[Name], LEN(@start)) = @start 
END

EXEC dbo.usp_GetTownsStartingWith2 b

-- Exercise 4
CREATE PROCEDURE usp_GetEmployeesFromTown (@town VARCHAR(50))
AS
BEGIN
	SELECT e.FirstName, e.LastName
	  FROM Employees e
	  JOIN Addresses a ON a.AddressID = e.AddressID
	  JOIN Towns t ON t.TownID = a.TownID
	 WHERE t.[Name] = @town
END

EXEC dbo.usp_GetEmployeesFromTown 'Sofia'

-- Exercise 5
CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL)
RETURNS NVARCHAR(10)
AS
BEGIN
	DECLARE @salaryLevel NVARCHAR(10)
	IF(@salary < 30000)
	BEGIN
		SET @salaryLevel = 'Low'
	END
	ELSE IF(@salary <= 50000)
	BEGIN
		SET @salaryLevel = 'Average'
	END
	ELSE
	BEGIN
		SET @salaryLevel = 'High'
	END

	RETURN @salaryLevel
END

SELECT FirstName, LastName, e.Salary, dbo.ufn_GetSalaryLevel(e.Salary) AS [SalaryLevel]
  FROM Employees e

-- Exercise 6
CREATE PROCEDURE usp_EmployeesBySalaryLevel (@salaryLevel VARCHAR(10))
AS
BEGIN
	SELECT e.FirstName, e.LastName
	  FROM Employees e
	 WHERE dbo.ufn_GetSalaryLevel(e.Salary) = @salaryLevel
END

EXEC dbo.usp_EmployeesBySalaryLevel high

-- Exercise 7
CREATE FUNCTION ufn_IsWordComprised(@setOfLetters VARCHAR(MAX), @word VARCHAR(MAX)) 
RETURNS BIT
AS
BEGIN
	DECLARE @counter INT = 1
	DECLARE @currentLetter CHAR(1)

	WHILE(@counter <= LEN(@word))
	BEGIN
		SET @currentLetter = SUBSTRING(@word, @counter, 1)

		DECLARE @charIndex INT = CHARINDEX(@currentLetter, @setOfLetters)
		IF(@charIndex <= 0)
		BEGIN
			RETURN 0
		END

		SET @counter += 1
	END

	RETURN 1
END

SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')

-- Exercise 8
CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT)
AS
BEGIN
    -- delete all working on projects by people that are intented to be deleted
	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN (	
		SELECT EmployeeID
		  FROM Employees
		 WHERE DepartmentID = @departmentId		
	)
	
	-- set ManagerID to null
	UPDATE Employees
	SET ManagerID = NULL
	WHERE ManagerID IN(	
	-- people i want to delete
		SELECT EmployeeID
		  FROM Employees
		 WHERE DepartmentID = @departmentId		
	)

	-- Set column ManagerId(Departments) to be nullable
	ALTER TABLE Departments
	ALTER COLUMN ManagerId INT

	--set ManagerId to NUll
	UPDATE Departments
	SET ManagerID = NULL
	WHERE DepartmentID = @departmentId

	DELETE FROM Employees
	WHERE DepartmentID = @departmentId

	DELETE FROM Departments
	WHERE DepartmentID = @departmentId

	SELECT COUNT(*) FROM Employees
	WHERE DepartmentID = @departmentId
			
END

USE [Bank]
-- Exercise 9
CREATE PROCEDURE usp_GetHoldersFullName 
AS
BEGIN
	SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name] 
	  FROM AccountHolders
END

EXEC usp_GetHoldersFullName

-- Exercise 10
CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@number DECIMAL(15, 2))
AS
BEGIN
	SELECT ah.FirstName, ah.LastName
	  FROM(
		SELECT a.AccountHolderId, SUM(a.Balance) AS [Balance]
	   	  FROM Accounts a
		GROUP BY a.AccountHolderId
		  HAVING SUM(a.Balance) > @number	
		) AS dt
	  JOIN AccountHolders AS ah ON dt.AccountHolderId = ah.Id
	ORDER BY ah.FirstName, ah.LastName
END

-- works too

--CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan (@number DECIMAL(15,2))
--AS
--BEGIN
--	SELECT ah.FirstName, ah.LastName
--	  FROM Accounts a 
--	  JOIN AccountHolders AS ah ON a.AccountHolderId = ah.Id
--  GROUP BY ah.FirstName, ah.LastName
--	HAVING SUM(a.Balance) > @number
--  ORDER BY ah.FirstName, ah.LastName
--END

EXEC dbo.usp_GetHoldersWithBalanceHigherThan 5000000

-- Exercise 11
CREATE FUNCTION ufn_CalculateFutureValue (@sum DECIMAL(15, 2), @yearlyInterestRate FLOAT, @numberOfYears INT)
RETURNS DECIMAL(15,4)
AS
BEGIN
	DECLARE @futureValue DECIMAL(15,4)
	SET @futureValue = @sum * POWER((1 + @yearlyInterestRate), @numberOfYears)
	RETURN @futureValue
END

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)

-- Exercises 12
CREATE PROCEDURE usp_CalculateFutureValueForAccount (@accountId INT, @interest FLOAT)
AS
BEGIN
	DECLARE @years INT = 5

	SELECT a.Id, ah.FirstName, ah.LastName, a.Balance AS [Current Balance], dbo.ufn_CalculateFutureValue(a.Balance, @interest ,5) AS [Balance in 5 years]
	  FROM Accounts a
	  JOIN AccountHolders ah ON a.AccountHolderId = ah.Id
	 WHERE a.Id = @accountId
END

EXEC usp_CalculateFutureValueForAccount 1, 0.1

USE [Diablo]

GO
-- Exercise 13
CREATE FUNCTION ufn_CashInUsersGames (@game VARCHAR(MAX))
RETURNS @output TABLE (SumCash DECIMAL(18, 4))
AS
BEGIN
	INSERT INTO @output SELECT(
	SELECT SUM(Cash) AS [SumCash] FROM(
		SELECT *, ROW_NUMBER() OVER (ORDER BY us.Cash DESC) AS [RowNum]
		FROM UsersGames us
		WHERE GameId IN (
		SELECT Id 
			FROM Games
		WHERE [Name] = @game
		)) AS [RowNumTable]
	WHERE [RowNumTable].RowNum % 2 <> 0)

	RETURN
END

SELECT * FROM dbo.ufn_CashInUsersGames ('Love in a mist')