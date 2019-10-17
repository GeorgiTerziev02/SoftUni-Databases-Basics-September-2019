CREATE DATABASE ColonialJourney 

USE ColonialJourney 

CREATE TABLE Planets(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(30) NOT NULL
)

CREATE TABLE Spaceports(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	PlanetId INT FOREIGN KEY REFERENCES Planets(Id) NOT NULL
)

CREATE TABLE Spaceships(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL,
	Manufacturer VARCHAR(30) NOT NULL,
	LightSpeedRate INT DEFAULT 0
)

CREATE TABLE Colonists(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Ucn VARCHAR(10) UNIQUE NOT NULL,
	BirthDate DATE NOT NULL
)

CREATE TABLE Journeys(
	Id INT PRIMARY KEY IDENTITY,
	JourneyStart DATETIME2 NOT NULL,
	JourneyEnd DATETIME2 NOT NULL,
	Purpose VARCHAR(11),
	CONSTRAINT CHK_Purpose CHECK (Purpose IN ('Medical', 'Technical', 'Educational', 'Military')),
	DestinationSpaceportId INT FOREIGN KEY REFERENCES Spaceports(Id) NOT NULL,
	SpaceshipId INT FOREIGN KEY REFERENCES Spaceships(Id) NOT NULL
)

CREATE TABLE TravelCards(
	Id INT PRIMARY KEY IDENTITY,
	CardNumber CHAR(10) UNIQUE NOT NULL,
	JobDuringJourney VARCHAR(8) NOT NULL,
	CONSTRAINT CHK_JobDuringJourney CHECK (JobDuringJourney IN ('Pilot', 'Engineer', 'Trooper', 'Cleaner', 'Cook')),
	ColonistId INT FOREIGN KEY REFERENCES Colonists(Id) NOT NULL,
	JourneyId INT FOREIGN KEY REFERENCES Journeys(Id) NOT NULL
)

-- Exercise 2
INSERT INTO Planets ([Name]) VALUES
	('Mars'),
	('Earth'),
	('Jupiter'),
	('Saturn')

INSERT INTO Spaceships ([Name], Manufacturer, LightSpeedRate) VALUES
	('Golf',	'VW',	3),
	('WakaWaka',	'Wakanda',	4),
	('Falcon9',	'SpaceX',	1),
	('Bed'	,'Vidolov',	6)

-- Exercise 3
UPDATE Spaceships
SET LightSpeedRate += 1
WHERE Id BETWEEN 8 AND 12

-- Exercise 4
DELETE FROM TravelCards
WHERE JourneyId IN (1, 2, 3)

DELETE FROM Journeys
WHERE Id IN (1, 2, 3)

-- Exercise 5
  SELECT CardNumber, JobDuringJourney 
    FROM TravelCards
ORDER BY CardNumber

-- Exercise 6
  SELECT Id, CONCAT(FirstName, ' ', LastName) AS [FullName], Ucn
    FROM Colonists
ORDER BY FirstName, LastName, Id

-- Exercise 7
  SELECT Id, FORMAT(JourneyStart, 'dd/MM/yyyy') AS [JourneyStart], FORMAT(JourneyEnd, 'dd/MM/yyyy') AS [JourneyEnd]
    FROM Journeys
   WHERE Purpose = 'Military'
ORDER BY JourneyStart

-- Exercise 8
  SELECT c.Id, CONCAT(c.FirstName, ' ', c.LastName) AS [full_name]
    FROM TravelCards tc
    JOIN Colonists c ON tc.ColonistId = c.Id 
   WHERE JobDuringJourney = 'Pilot'
ORDER BY c.Id

-- Exercise 9
SELECT COUNT(*) AS [count]
  FROM Journeys j
  JOIN TravelCards tc ON tc.JourneyId = j.Id
  JOIN Colonists c ON c.Id = tc.ColonistId
 WHERE j.Purpose = 'Technical'

-- Exercise 10
SELECT dt.[Name] AS [SpaceshipName], sp.[Name] AS [SpaceportName]
FROM
	  (SELECT TOP(1) * 
	   FROM Spaceships
	   ORDER BY LightSpeedRate DESC) AS dt
JOIN Journeys j ON j.SpaceshipId = dt.Id
JOIN Spaceports sp ON sp.Id = j.DestinationSpaceportId

-- Exercise 11
  SELECT s.[Name], s.Manufacturer
    FROM Spaceships s
    JOIN Journeys j ON s.Id = j.SpaceshipId
    JOIN TravelCards tc ON tc.JourneyId = j.Id
    JOIN Colonists c ON c.Id = tc.ColonistId
   WHERE DATEDIFF(YEAR, c.BirthDate, '01/01/2019') < 30 AND tc.JobDuringJourney = 'Pilot'
ORDER BY s.[Name]

-- Exercise 12
  SELECT p.[Name], sp.[Name]
    FROM Planets p
    JOIN Spaceports sp ON p.Id = sp.PlanetId
    JOIN Journeys j ON j.DestinationSpaceportId = sp.Id
   WHERE j.Purpose = 'Educational'
ORDER BY sp.[Name] DESC

-- Exercise 13
  SELECT p.[Name], COUNT(j.Id) AS [JourneysCount] 
    FROM Planets p
    JOIN Spaceports sp ON p.Id = sp.PlanetId
    JOIN Journeys j ON j.DestinationSpaceportId = sp.Id
GROUP BY p.[Name]
ORDER BY JourneysCount DESC, p.[Name] 

-- Exercise 14
SELECT TOP(1) dt.Id, p.[Name] AS [Planet Name], sp.[Name] AS [SpaceportName], dt.Purpose AS [JourneyPurpose]
  FROM (
		SELECT j.Id, j.Purpose, DATEDIFF(SECOND, j.JourneyStart, j.JourneyEnd) AS [Length], j.DestinationSpaceportId
		FROM Journeys j
		) AS dt
 JOIN Spaceports sp ON sp.Id = dt.DestinationSpaceportId
 JOIN Planets p ON p.Id = sp.PlanetId
ORDER BY dt.[Length]

-- Exercise 15
SELECT TOP(1) tc.JourneyId, tc.JobDuringJourney
  FROM TravelCards tc
 WHERE tc.JourneyId = (SELECT TOP(1) Id FROM Journeys ORDER BY DATEDIFF(SECOND, JourneyStart, JourneyEnd) DESC)
GROUP BY tc.JourneyId, tc.JobDuringJourney
ORDER BY COUNT(tc.JobDuringJourney)

-- exercise 16 - not clear task????

-- Exercise 17
    SELECT p.[Name], COUNT(sp.Id)
      FROM Spaceports sp
RIGHT JOIN Planets p ON sp.PlanetId = p.Id
  GROUP BY p.Id, p.[Name]
  ORDER BY COUNT(sp.Id) DESC, p.[Name]

-- Exercise 18
CREATE FUNCTION udf_GetColonistsCount(@PlanetName VARCHAR (30))
RETURNS INT
AS
BEGIN
	RETURN(
	SELECT COUNT(*)
	  FROM Planets p
	  JOIN Spaceports sp ON sp.PlanetId = p.Id
	  JOIN Journeys j ON j.DestinationSpaceportId = sp.Id
	  JOIN TravelCards tc ON tc.JourneyId = j.Id
	 WHERE p.[Name] = @PlanetName)

END 

SELECT dbo.udf_GetColonistsCount('Otroyphus')

-- Exercise 19
CREATE PROCEDURE usp_ChangeJourneyPurpose(@JourneyId INT, @NewPurpose VARCHAR(50))
AS
BEGIN



END 