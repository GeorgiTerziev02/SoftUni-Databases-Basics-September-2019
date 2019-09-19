CREATE DATABASE HOTEL

CREATE TABLE Employees(
    Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Title NVARCHAR(50),
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees(FirstName, LastName) VALUES
    ('Ivan', 'Ivanov'),
	('Georgi', 'Don'),
	('Toni', 'Ton')

--SELECT * FROM Employees

CREATE TABLE Customers(
    AccountNumber INT PRIMARY KEY NOT NULL,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(10) NOT NULL,
	EmergencyName NVARCHAR(50),
	EmergencyNumber VARCHAR(12),
	Notes NVARCHAR(MAX)
)

INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber) VALUES
    (55, 'Pesho', 'Ivanov', '0959759957'), 
	(44, 'Gosho', 'Sasg', '1232435354'),
	(33, 'Alek', 'Ivanov', '0954345427')

--SELECT * FROM Customers

CREATE TABLE RoomStatus(
    RoomStatus NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RoomStatus(RoomStatus) VALUES
    ('Full'),
	('Empty'),
	('Half')

--SELECT * FROM RoomStatus

CREATE TABLE RoomTypes(
    RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO RoomTypes(RoomType) VALUES
    ('Large'),
	('Medium'),
	('Small')

--SELECT * FROM RoomTypes

CREATE TABLE BedTypes(
    BedType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO BedTypes(BedType) VALUES
    ('Double'),
	('Single'),
	('Family')

--SELECT * FROM BedTypes

CREATE TABLE Rooms(
    RoomNumber INT PRIMARY KEY NOT NULL,
	RoomType NVARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
	BedType NVARCHAR(50) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate INT,
	RoomStatus NVARCHAR(50) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Rooms(RoomNumber, RoomType, BedType, RoomStatus) VALUES
    (1, 'Large', 'Double', 'Full'),
	(2, 'Medium', 'Single', 'Half'),
	(3, 'Small', 'Family', 'Empty')

--SELECT * FROM Rooms

CREATE TABLE Payments(
    Id INT PRIMARY KEY IDENTITY(1,1),
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATE,
	AccountNumber INT,
	FirstDateOccupied DATE,
	LastDateOccupied DATE,
	TotalDays INT,
	AmountCharged DECIMAL(15,2),
	TaxRate INT,
	TaxAmount DECIMAL(15,2),
	PaymentTotal DECIMAL(15,2),
	Notes NVARCHAR(MAX)
)

INSERT INTO Payments(EmployeeId) VALUES
    (1),
	(2),
	(3)

--SELECT * FROM Payments

CREATE TABLE Occupancies(
    Id INT PRIMARY KEY IDENTITY(1,1),
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATE,
	AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied INT,
	PhoneCharge DECIMAL(15,2),
	Notes NVARCHAR(MAX)
)

INSERT INTO Occupancies (EmployeeId, AccountNumber, RoomNumber) VALUES
    (1, 55, 1),
	(2, 44, 2),
	(3, 33, 3)