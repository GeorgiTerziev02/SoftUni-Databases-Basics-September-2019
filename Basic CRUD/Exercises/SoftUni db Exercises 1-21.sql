USE SoftUni
GO

-- Exercise 2
-- Write a SQL query to find all available information about the Departments.
SELECT * FROM Departments

-- Exercise 3
-- Write SQL query to find all Department names.
SELECT [Name] FROM Departments

-- Exercise 4
-- Write SQL query to find the first name, last name and salary of each employee.
SELECT FirstName, LastName, Salary FROM Employees

-- Exercise 5
-- Write SQL query to find the first, middle and last name of each employee. 
SELECT FirstName, MiddleName, LastName FROM Employees

-- Exercise 6
--Write a SQL query to find the email address of each employee. (By his first and last name). 
-- Consider that the email domain is softuni.bg. Emails should look like “John.Doe@softuni.bg". The produced column should be named "Full Email Address". 
SELECT FirstName + '.' + LastName + '@softuni.bg' 
    AS [Full Email Address]
  FROM Employees

-- Exercise 7
-- Write a SQL query to find all different employee’s salaries. Show only the salaries.
SELECT DISTINCT Salary FROM Employees

-- Exercise 8
-- Write a SQL query to find all information about the employees whose job title is “Sales Representative”. 
SELECT * FROM Employees
    WHERE JobTitle = 'Sales Representative'

-- Exercise 9
-- Write a SQL query to find the first name, last name and job title of all employees whose salary is in the range [20000, 30000].
SELECT FirstName, LastName, JobTitle 
  FROM Employees
 WHERE Salary BETWEEN 20000 AND 30000

-- Exercise 10
-- Write a SQL query to find the full name of all employees whose salary is 25000, 14000, 12500 or 23600.
-- Full Name is combination of first, middle and last name (separated with single space) and they should be in one column called “Full Name”.
SELECT CONCAT(FirstName, ' ',  MiddleName + ' ', LastName) 
    AS [Full Name]
  FROM Employees
 WHERE Salary IN (25000, 14000, 12500, 23600)

-- Exercise 11
-- Write a SQL query to find first and last names about those employees that does not have a manager. 
SELECT FirstName, LastName 
  FROM Employees
 WHERE ManagerID IS NULL

-- Exercise 12
-- Write a SQL query to find first name, last name and salary of those employees who has salary more than 50000. Order them in decreasing order by salary. 
SELECT FirstName, LastName, Salary
  FROM Employees
 WHERE Salary >= 50000
 ORDER BY Salary DESC

-- Exercise 13
-- Write SQL query to find first and last names about 5 best paid Employees ordered descending by their salary.
SELECT TOP(5) FirstName, LastName
  FROM Employees
 ORDER BY Salary DESC

-- Exercise 14
-- Write a SQL query to find the first and last names of all employees whose department ID is different from 4.
SELECT FirstName, LastName
  FROM Employees
 WHERE DepartmentID <> 4

-- Exercise 15
-- Write a SQL query to sort all records in the Employees table by the following criteria: 
-- •	First by salary in decreasing order
-- •	Then by first name alphabetically
-- •	Then by last name descending
-- •	Then by middle name alphabetically
SELECT * FROM Employees
 ORDER BY Salary DESC,
          FirstName ASC,
		  LastName DESC,
		  MiddleName ASC

-- Exercise 16
-- Write a SQL query to create a view V_EmployeesSalaries with first name, last name and salary for each employee.

GO

CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary
  FROM Employees

GO

SELECT * FROM V_EmployeesSalaries

-- Exercise 17
-- Write a SQL query to create view V_EmployeeNameJobTitle with full employee name and job title. When middle name is NULL replace it with empty string (‘’).

GO

CREATE VIEW V_EmployeeNameJobTitle 
         AS
     SELECT CONCAT(FirstName, ' ', MiddleName, ' ', LastName) 
	     AS [Full Name], JobTitle
		 AS [Job Title]
       FROM Employees

GO

SELECT * FROM V_EmployeeNameJobTitle

-- Exercise 18
-- Write a SQL query to find all distinct job titles.
SELECT DISTINCT JobTitle
  FROM Employees

-- Exercise 19
-- Write a SQL query to find first 10 started projects. Select all information about them and sort them by start date, then by name.
SELECT TOP(10) * 
  FROM Projects
 ORDER BY StartDate, Name

-- Exercise 20
-- Write a SQL query to find last 7 hired employees. Select their first, last name and their hire date.
SELECT TOP(7) FirstName, LastName, HireDate
  FROM Employees
 ORDER BY HireDate DESC

-- Exercise 21
-- Write a SQL query to increase salaries of all employees that are in the Engineering, Tool Design, Marketing or Information Services department by 12%.
-- Then select Salaries column from the Employees table. After that exercise restore your database to revert those changes.
UPDATE Employees
   SET Salary += Salary * 0.12
 WHERE DepartmentID IN (1, 2, 4, 11)

 SELECT Salary FROM Employees

 -- instead 1, 2, 4, 11
 SELECT DepartmentID 
   FROM Departments
  WHERE [Name] IN ('Engineering', 'Tool Design', 'Marketing' , 'Information Services')