CREATE DATABASE SoftUni

CREATE TABLE Towns(
    Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
    Id INT PRIMARY KEY IDENTITY(1,1),
	AddressText NVARCHAR(100) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments(
    Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees(
    Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(50) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
	HireDate DATE,
	Salary DECIMAL(15,2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)


INSERT INTO Towns ([Name]) VALUES
    ('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO Departments ([Name]) VALUES
    ('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary) VALUES
    ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',	4,	CONVERT(datetime, '01/02/2013', 103), 3500.00),
	('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1,	CONVERT(datetime, '02/03/2004', 103), 4000.00),
	('Maria', 'Petrova', 'Ivanova', 'Intern',	5,	CONVERT(datetime, '28/08/2016', 103), 525.25),
	('Georgi', 'Teziev', 'Ivanov', 'CEO',	2,	CONVERT(datetime, '09/12/2007', 103), 3000.00),
	('Peter', 'Pan', 'Pan', 'Intern',	3,	CONVERT(datetime, '28/08/2016', 103), 599.88)

--Exercise 20
SELECT * FROM Towns
ORDER BY [Name]
SELECT * FROM Departments
ORDER BY [Name]
SELECT * FROM Employees
ORDER BY Salary DESC

--Exercise 21

SELECT [Name] FROM Towns
ORDER BY [Name]
SELECT [Name] FROM Departments
ORDER BY [Name]
SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY SALARY DESC

--Exercise 22

UPDATE Employees
SET Salary+=Salary*0.1

SELECT Salary FROM Employees