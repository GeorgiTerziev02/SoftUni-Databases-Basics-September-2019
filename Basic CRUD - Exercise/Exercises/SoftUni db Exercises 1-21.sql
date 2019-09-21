-- Exercise 2
SELECT * FROM Departments

-- Exercise 3
SELECT [Name] FROM Departments

-- Exercise 4
SELECT FirstName, LastName, Salary FROM Employees

-- Exercise 5
SELECT FirstName, MiddleName, LastName FROM Employees

-- Exercise 6
SELECT FirstName + '.' + LastName + '@softuni.bg' AS 'Full Email Address'
    FROM Employees

-- Exercise 7
SELECT DISTINCT Salary FROM Employees

-- Exercise 8
SELECT * FROM Employees
    WHERE JobTitle = 'Sales Representative'

-- Exercise 9
SELECT FirstName, LastName, JobTitle FROM Employees
    WHERE Salary BETWEEN 20000 AND 30000

-- Exercise 10 --TODO:fix
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS 'Full Name'
    FROM Employees
	WHERE Salary IN (25000, 14000, 12500, 23600)