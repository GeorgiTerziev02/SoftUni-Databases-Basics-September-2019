CREATE OR ALTER PROC usp_AddProjectToEmployee(@employeeId INT, @projectId INT)
AS
BEGIN TRANSACTION
	INSERT INTO EmployeesProjects
	VALUES (@employeeId, @projectId)

	DECLARE @projectForEmployee INT
	SET @projectForEmployee = 
	(
		SELECT COUNT(*) FROM EmployeesProjects
		WHERE EmployeeID = @employeeId	
	)

	IF (@projectForEmployee > 5)
	BEGIN
		ROLLBACK
		RAISERROR('Too many projects for employee', 16, 1)
		RETURN
	END

COMMIT

GO

EXEC dbo.usp_AddProjectToEmployee 1,3

----------

CREATE OR ALTER TRIGGER tr_NoEmptyTownNames ON Towns FOR UPDATE
AS
BEGIN
	IF(EXISTS(
		SELECT * FROM inserted
		WHERE [Name] IS NULL OR LEN([Name]) < 2	
	))
	BEGIN
		ROLLBACK
		RAISERROR ('Town names must have at least 2 symbols.', 16, 1)
	END
END

GO

UPDATE Towns
SET [Name] = 'A'
WHERE TownID = 1

-- update column
CREATE OR ALTER TRIGGER tr_SetUpdatedOnDate ON Employees FOR UPDATE 
AS
BEGIN
	UPDATE Employees
	SET UpdatedOn = GETDATE()
	FROM Employees e
	JOIN inserted i ON i.EmployeeId = e.EmployeeId
END

GO
UPDATE Employees
SET FirstName = 'Ivan'
WHERE EmployeeID = 1

SELECT * FROM Employees
