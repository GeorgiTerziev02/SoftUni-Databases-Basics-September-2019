CREATE DATABASE Airport

USE Airport

CREATE TABLE Planes(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL,
	Seats INT NOT NULL,
	[Range] INT NOT NULL
)

CREATE TABLE Flights(
	Id INT PRIMARY KEY IDENTITY,
	DepartureTime DATETIME,
	ArrivalTime DATETIME,
	Origin VARCHAR(50) NOT NULL,
	Destination VARCHAR(50) NOT NULL,
	PlaneId INT FOREIGN KEY REFERENCES Planes(Id) NOT NULL
)

CREATE TABLE Passengers(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Age INT NOT NULL,
	[Address] VARCHAR(30) NOT NULL,
	PassportId CHAR(11) NOT NULL
)

CREATE TABLE LuggageTypes(
	Id INT PRIMARY KEY IDENTITY,
	[Type] VARCHAR(30) NOT NULL
)

CREATE TABLE Luggages(
	Id INT PRIMARY KEY IDENTITY,
	LuggageTypeId INT FOREIGN KEY REFERENCES LuggageTypes(Id) NOT NULL,
	PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL
)

CREATE TABLE Tickets(
	Id INT PRIMARY KEY IDENTITY,
	PassengerId INT FOREIGN KEY REFERENCES Passengers(Id) NOT NULL,
	FlightId INT FOREIGN KEY REFERENCES Flights(Id) NOT NULL,
	LuggageId INT FOREIGN KEY REFERENCES Luggages(Id) NOT NULL,
	Price DECIMAL(18, 2) NOT NULL
)

-- Exercise 2
INSERT INTO Planes ([Name], Seats, [Range]) VALUES
	('Airbus 336', 112, 5132),
	('Airbus 330', 432, 5325),
	('Boeing 369', 231, 2355),
	('Stelt 297', 254, 2143),
	('Boeing 338', 165, 5111),
	('Airbus 558', 387, 1342),
	('Boeing 128', 345, 5541)

INSERT INTO LuggageTypes ([Type]) VALUES
	('Crossbody Bag'),
	('School Backpack'),
	('Shoulder Bag')
	
SELECT * FROM LuggageTypes 

-- Exercise 3
UPDATE Tickets
SET Price += t.Price * 0.13
FROM Tickets t
JOIN Flights f ON f.Id = t.FlightId
WHERE f.Destination = 'Carlsbad'

-- Exercise 4
DELETE FROM Tickets
 WHERE FlightId IN (SELECT Id FROM Flights
			WHERE Destination = 'Ayn Halagim'
 )

DELETE FROM Flights 
 WHERE Destination = 'Ayn Halagim' 

-- Exercise 5 
SELECT *
  FROM Planes
 WHERE [Name] LIKE '%tr%'
ORDER BY Id, [Name], Seats, [Range]

-- Exercise 6
  SELECT FlightId, SUM(Price) AS [Price]
    FROM Tickets
GROUP BY FlightId
ORDER BY SUM(Price) DESC, FlightId 

-- Exercise 7
  SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name] , f.Origin, f.Destination
    FROM Passengers p 
    JOIN Tickets t ON p.Id = t.PassengerId
    JOIN Flights f ON f.Id = t.FlightId
ORDER BY [Full Name], f.Origin, f.Destination

-- Exercise 8
   SELECT FirstName, LastName, Age
     FROM Passengers p
LEFT JOIN Tickets t ON p.Id = t.PassengerId
    WHERE t.Id IS NULL
 ORDER BY Age DESC, FirstName, LastName

-- Exercise 9
  SELECT CONCAT(p.FirstName, ' ', p.LastName) AS [Full Name], pl.[Name], CONCAT(f.Origin, ' - ', f.Destination) AS [Trip], lt.[Type] AS [Luggage Type]
    FROM Passengers p
	JOIN Tickets t ON t.PassengerId = p.Id
    JOIN Flights f ON t.FlightId = f.Id
    JOIN Planes pl ON f.PlaneId = pl.Id
    JOIN Luggages l ON l.Id = t.LuggageId
    JOIN LuggageTypes lt ON lt.Id = l.LuggageTypeId
ORDER BY [Full Name], pl.[Name], f.Origin, f.Destination, [Luggage Type]

-- Exercise 10
SELECT p.[Name], p.Seats, COUNT(t.Id) AS [PassengersCount]
  FROM Planes p
LEFT JOIN Flights AS f ON f.PlaneId = p.Id
LEFT JOIN Tickets AS t ON t.FlightId = f.Id
GROUP BY p.[Name], p.Seats
ORDER BY PassengersCount DESC, p.Name, p.Seats

-- Exercise 11
CREATE FUNCTION udf_CalculateTickets(@origin VARCHAR(MAX), @destination VARCHAR(MAX), @peopleCount INT) 
RETURNS VARCHAR(100)
AS
BEGIN
	IF(@peopleCount <= 0)
	BEGIN
		RETURN 'Invalid people count!'
	END

	DECLARE @ticketPrice DECIMAL(18,2) = (
		SELECT t.Price 
		  FROM Tickets t
		  JOIN Flights f ON t.FlightId = f.Id
		 WHERE f.Origin = @origin AND f.Destination = @destination
	)

	IF(@ticketPrice IS NULL)
	BEGIN
		RETURN 'Invalid flight!'
	END

	DECLARE @total DECIMAL(18, 2) = @ticketPrice * @peopleCount

	RETURN CONCAT('Total price ', @total)
END

SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', 33)
SELECT dbo.udf_CalculateTickets('Kolyshley','Rancabolang', -1)
SELECT dbo.udf_CalculateTickets('Invalid','Rancabolang', 33)


-- Exercise 12
CREATE PROCEDURE usp_CancelFlights
AS
BEGIN
	UPDATE Flights
	SET DepartureTime = NULL, ArrivalTime = NULL
	WHERE DATEDIFF(SECOND, DepartureTime, ArrivalTime) > 0
END

EXEC usp_CancelFlights