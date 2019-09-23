SELECT FirstName + ' ' + LastName AS 'FullName',
    JobTitle,
	Salary
    FROM Employees

SELECT *
    FROM Employees
	WHERE DepartmentID IN (1, 2, 3)

SELECT *
    FROM Employees
  WHERE MiddleName IS NULL

SELECT * 
    FROM Employees
  ORDER BY Salary

CREATE VIEW v_EmployeesSalaryInfo AS
SELECT FirstName + ' ' + LastName AS 'FullName',
	Salary
    FROM Employees

SELECT * FROM v_EmployeesSalaryInfo

SELECT FirstName, LastName, JobTitle
    INTO MyFiredEmployees
	FROM Employees

SELECT * FROM MyFiredEmployees

CREATE SEQUENCE sq_MySequence
         AS INT
	 START WITH 1
   INCREMENT BY 1

SELECT NEXT VALUE FOR sq_MySequence

CREATE SEQUENCE sq_MySequenceNegative
         AS INT
	 START WITH 10
   INCREMENT BY -1

SELECT NEXT VALUE FOR sq_MySequenceNegative

CREATE SEQUENCE sq_MySequenceMinMax2
         AS INT
	 START WITH 10
   INCREMENT BY 10
   MINVALUE 10
   MAXVALUE 50
   CYCLE

SELECT NEXT VALUE FOR sq_MySequenceMinMax2

SELECT * FROM Addresses
WHERE TownID = 1

DELETE FROM Towns
      WHERE TownID = 1

UPDATE Addresses
SET TownID = NULL

SELECT * FROM Towns

TRUNCATE TABLE Towns
DELETE FROM Towns

INSERT INTO Towns VALUES ('Plovdiv')

UPDATE Projects
SET EndDate = GETDATE()
WHERE EndDate IS NULL