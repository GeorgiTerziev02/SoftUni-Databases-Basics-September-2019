CREATE DATABASE CarRental

CREATE TABLE Categories(
    Id INT PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate INT,
	WeeklyRate INT,
	MonthlyRate INT,
	WeekendRate INT
)

INSERT INTO Categories (CategoryName) VALUES
    ('Truck'),
	('Car'),
	('Bus')

--SELECT * FROM Categories

CREATE TABLE Cars(
    Id INT PRIMARY KEY IDENTITY(1,1),
	PlateNumber INT NOT NULL,
	Manufacturer NVARCHAR(50) NOT NULL,
	Model NVARCHAR(50),
	CarYear INT,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Doors INT,
	Picture VARBINARY(MAX),
	Condition NVARCHAR(100),
	Available BIT
)

INSERT INTO Cars(PlateNumber, CategoryId, Manufacturer) VALUES
    (55, 1, 'BMW'),
	(51, 2, 'Audi'),
	(50, 3, 'Merz')

--SELECT * FROM Cars

--•	Employees (Id, FirstName, LastName, Title, Notes)

CREATE TABLE Employees(
    Id INT PRIMARY KEY IDENTITY (1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(MAX),
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName, LastName) VALUES
    ('Ivan', 'Ivanov'),
    ('Gosho', 'Goshov'),
	('Marto', 'Martev')

--SELECT * FROM Employees