CREATE DATABASE MyDB
USE MyDB

-- Exercise 1
CREATE TABLE Passports(
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber VARCHAR(50) NOT NULL
)

CREATE TABLE Persons(
	ID INT PRIMARY KEY IDENTITY(1, 1),
	FirstName VARCHAR(50) NOT NULL,
	Salary DECIMAL(15, 2) NOT NULL,
	PassportID INT FOREIGN KEY REFERENCES Passports(PassportID) NOT NULL
)

INSERT INTO Passports (PassportID, PassportNumber) VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')

INSERT INTO Persons (FirstName, Salary, PassportID) VALUES
	('Roberto', 43300.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

SELECT * FROM Persons
SELECT * FROM Passports

-- Exercise 2
CREATE TABLE Models(
	ModelID INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	ManufacturerID INT NOT NULL
)

CREATE TABLE Manufacturers(
	ManufacturerID INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	EstablishedOn DATE NOT NULL
)

INSERT INTO Models(ModelID, [Name], ManufacturerID) VALUES
	(101, 'X1', 1),
	(102, 'i6', 1),
	(103, 'Model S', 2),
	(104, 'Model X', 2),
	(105, 'Model 3', 2),
	(106, 'Nova', 3)

INSERT INTO Manufacturers(ManufacturerID, [Name], EstablishedOn) VALUES
	(1, 'BMW', '07/03/1916'),
	(2, 'Tesla', '01/01/2003'),
	(3, 'Lada', '01/05/1966')

ALTER TABLE Models
ADD CONSTRAINT PK_Models
PRIMARY KEY (ModelID)

ALTER TABLE Manufacturers
ADD CONSTRAINT PK_Manufacturers
PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD CONSTRAINT FK_Models_Manufacturers
FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)

SELECT * FROM Models
SELECT * FROM Manufacturers

-- Exercise 3
CREATE TABLE Students(
	StudentID INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Exams(
	ExamID INT NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE StudentsExams(
	StudentID INT NOT NULL,
	ExamID INT NOT NULL
)

INSERT INTO Students (StudentID, [Name]) VALUES
	(1, 'Mila'),
	(2, 'Toni'),
	(3, 'Roni')

INSERT INTO Exams (ExamID, [Name]) VALUES
	(101, 'SpringMVC'),
	(102, 'Neo4j'),
	(103, 'Oracle 11g')

INSERT INTO StudentsExams (StudentID, ExamID) VALUES
	(1, 101),
	(1, 102),
	(2, 101),
	(3, 103),
	(2, 102),
	(2, 103)

ALTER TABLE Students
ADD CONSTRAINT PK_Students
PRIMARY KEY (StudentID)

ALTER TABLE Exams
ADD CONSTRAINT PK_Exams
PRIMARY KEY(ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentsExams_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE StudentsExams
ADD CONSTRAINT FK_StudentsExams_Exams
FOREIGN KEY (ExamID)
REFERENCES Exams(ExamID)

ALTER TABLE StudentsExams
ADD CONSTRAINT PK_StudentsExams
PRIMARY KEY(StudentID, ExamID)

-- Exercise 4
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY,
	[Name] NVARCHAR(50) NOT NULL,
	ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers (TeacherID, [Name], ManagerID) VALUES 
	(101, 'John', NULL),
	(102, 'Maya', 106),
	(103, 'Silvia', 106),
	(104, 'Ted', 105),
	(105, 'Mark', 101),
	(106, 'Greta', 101)

SELECT * FROM Teachers

-- Exericse 5
CREATE DATABASE [Online Store Database]
USE [Online Store Database]

CREATE TABLE Cities(
	CityID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Customers(
	CustomerID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	Birthday DATE NOT NULL,
	CityID INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE ItemTypes(
	ItemTypeID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	ItemTypeID INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID) NOT NULL
)

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY NOT NULL,
	CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID) NOT NULL
)

CREATE TABLE OrderItems(
	OrderID INT FOREIGN KEY REFERENCES Orders(OrderID) NOT NULL,
	ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
	CONSTRAINT PK_OrderItems
	PRIMARY KEY (OrderID, ItemID)	
)

DROP DATABASE [Online Store Database]

-- Exercise 6
CREATE DATABASE [University Database]
USE [University Database]

CREATE TABLE Majors(
	MajorID INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Subjects(
	SubjectID INT PRIMARY KEY NOT NULL,
	SubjectName VARCHAR(50) NOT NULL
)

CREATE TABLE Students(
	StudentID INT PRIMARY KEY NOT NULL,
	StudentNumber INT NOT NULL,
	StudentName VARCHAR(200) NOT NULL,
	MajorID INT FOREIGN KEY REFERENCES Majors(MajorID) NOT NULL
)

CREATE TABLE Agenda(
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL,
	SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID) NOT NULL,
	CONSTRAINT PK_Agenda
	PRIMARY KEY(StudentID, SubjectID)
)

CREATE TABLE Payments(
	PaymentID INT PRIMARY KEY NOT NULL,
	PaymentDate DATE NOT NULL,
	PaymentAmount DECIMAL(15, 2) NOT NULL,
	StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
)

DROP DATABASE [University Database]

USE [Geography]
-- Exercise 9
SELECT m.MountainRange, p.PeakName, p.Elevation FROM Peaks AS p
    JOIN Mountains AS m ON m.Id = p.MountainId 
	WHERE m.MountainRange = 'Rila'
	ORDER BY p.Elevation DESC