USE Airport

-- Exercise 5
  SELECT Origin, Destination
    FROM Flights
ORDER BY Origin, Destination

-- Exercise 8
SELECT TOP(10) p.FirstName, p.LastName, t.Price
  FROM Tickets t
RIGHT JOIN Passengers p ON t.PassengerId = p.Id 
ORDER BY t.Price DESC, p.FirstName, p.LastName

-- Exercise 9
  SELECT lt.[Type], COUNT(l.LuggageTypeId) AS [MostUsedLuggage]
    FROM Luggages l
	JOIN LuggageTypes lt ON l.LuggageTypeId = lt.Id
GROUP BY lt.[Type]
ORDER BY MostUsedLuggage DESC, lt.[Type]

-- Exercise 12
   SELECT p.PassportId, p.[Address] 
     FROM Passengers p
LEFT JOIN  Luggages l ON p.Id = l.PassengerId
    WHERE l.Id IS NULL
 ORDER BY p.PassportId, p.[Address]

-- Exercise 13
   SELECT p.FirstName, p.LastName, COUNT(t.Id) AS [Total Trips]
     FROM Passengers p
LEFT JOIN Tickets t ON t.PassengerId = p.Id
 GROUP BY p.FirstName, p.LastName
 ORDER BY [Total Trips] DESC, FirstName, LastName

-- Exercise 15
SELECT dt.FirstName, dt.LastName, dt.Destination, dt.Price
  FROM
	(SELECT p.Id, p.FirstName, p.LastName, Destination, t.Price, DENSE_RANK() OVER (PARTITION BY p.FirstName, p.LastName ORDER BY t.Price DESC) AS [Rank] 
	 FROM Passengers p
		JOIN Tickets t ON t.PassengerId = p.Id
		JOIN Flights f ON f.Id  = t.FlightId) AS dt
  WHERE dt.[Rank] = 1
ORDER BY dt.Price DESC, dt.FirstName, dt.LastName, dt.Destination

-- Exercise 16
   SELECT f.Destination, COUNT(t.Id) AS [FliesCount]
     FROM Flights f
LEFT JOIN Tickets t ON f.Id = t.FlightId
 GROUP BY f.Destination
 ORDER BY FliesCount DESC, f.Destination


-- Exercise 20
CREATE TABLE DeletedPlanes(
	Id INT,
	[Name] NVARCHAR(50),
	Seats INT,
	[Range] INT
)

CREATE TRIGGER t_Delete ON Planes
AFTER DELETE
AS
BEGIN
	INSERT INTO DeletedPlanes (Id, [Name], [Seats], [Range])
	   SELECT Id, [Name], [Seats], [Range] FROM deleted
END

DELETE Tickets
WHERE FlightId IN (SELECT Id FROM Flights WHERE PlaneId = 8)

DELETE FROM Flights
WHERE PlaneId = 8

DELETE FROM Planes
WHERE Id = 8

SELECT * FROM DeletedPlanes


