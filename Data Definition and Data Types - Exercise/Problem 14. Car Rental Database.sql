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

CREATE TABLE Customers(
    Id INT PRIMARY KEY IDENTITY(1,1),
	DriverLicenceNumber INT NOT NULL,
	FullName NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(100),
	City NVARCHAR(50),
	ZIPCode INT,
	Notes NVARCHAR(MAX)
)

INSERT INTO Customers (DriverLicenceNumber, FullName) VALUES
    (44, 'Pesho ivanov'),
	(33, 'Ivan ivanov'),
	(22, 'Georgi ivanov')

--SELECT * FROM Customers

CREATE TABLE RentalOrders(
    Id INT PRIMARY KEY IDENTITY(1,1),
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	TankLevel INT,
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT,
	TotalKilometrage INT,
	StartDate DATETIME,
	EndDate DATETIME,
	TotalDays INT,
	RateApplied INT,
	TaxRate INT,
	OrderStatus NVARCHAR(50),
	Notes NVARCHAR(MAX)
)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, KilometrageStart) VALUES
    (1, 2, 3, 200),
	(2, 3, 2, 2000),
	(3, 1, 1, 20000)

--SELECT * FROM RentalOrders