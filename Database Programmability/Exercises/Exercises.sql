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

-- Exercise 5
CREATE FUNCTION udf_GetSalaryLevel(@salary DECIMAL)
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

SELECT FirstName, LastName, e.Salary,dbo.udf_GetSalaryLevel(e.Salary) AS [SalaryLevel]
  FROM Employees e

-- Exercise ??j
CREATE OR ALTER PROCEDURE usp_InsertProject(@employeeId INT, @projectId INT)
AS
BEGIN
	DECLARE @totalProject INT
	SET @totalProject = 
	(
	 SELECT COUNT(*) 
	   FROM EmployeesProjects ep
	  WHERE ep.EmployeeID = @employeeId
	)

	IF(@totalProject > 3)
	BEGIN
		THROW 50001, 'Employees cannot have more than 3 projects', 1
	END

	INSERT INTO EmployeesProjects (EmployeeID, ProjectID) VALUES (@employeeId, @projectId)
END

GO

EXEC usp_InsertProject 28, 3