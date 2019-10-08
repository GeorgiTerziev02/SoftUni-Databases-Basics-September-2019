CREATE FUNCTION udf_ProcessText(@text NVARCHAR(50))
RETURNS NVARCHAR(50)
AS
BEGIN
	RETURN @text + ' Some Text'
END

SELECT dbo.udf_ProcessText(e.FirstName)
  FROM Employees e
  
CREATE OR ALTER PROC usp_OldestEmployees
AS
SELECT * 
FROM Employees
ORDER BY HireDate DESC

EXEC dbo.usp_OldestEmployees

GO

CREATE OR ALTER PROC usp_OldestEmployees (@totalEmployees INT, @maxSalary INT = 1000000)
AS
SELECT TOP (@totalEmployees) *
FROM Employees
WHERE Salary < @maxSalary
ORDER BY HireDate DESC

GO

EXEC usp_OldestEmployees 22, 10000

EXEC usp_OldestEmployees @maxSalary = 10000, @totalEmployees = 33

GO

CREATE PROCEDURE dbo.usp_AddNumbers
   @firstNumber SMALLINT,
   @secondNumber SMALLINT,
   @result INT OUTPUT
AS
   SET @result = @firstNumber + @secondNumber
GO

DECLARE @answer smallint
EXECUTE usp_AddNumbers 5, 6, @answer OUTPUT
SELECT 'The result is: ', @answer

GO

CREATE OR ALTER PROC usp_MultipleResults
AS
SELECT FirstName, LastName FROM Employees
SELECT FirstName, LastName, d.[Name] AS Department 
FROM Employees AS e 
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID;
GO

EXEC usp_MultipleResults



BEGIN TRY  
    -- Generate a divide-by-zero error.  
    SELECT 1/0
END TRY  
BEGIN CATCH  
    SELECT  
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_LINE() AS ErrorLine  
        ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH  
GO
