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