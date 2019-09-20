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