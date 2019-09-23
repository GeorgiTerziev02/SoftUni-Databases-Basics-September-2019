CREATE VIEW v_HighestPeak AS
  SELECT TOP(1) Elevation
    FROM Peaks
ORDER BY Elevation DESC

SELECT * FROM v_HighestPeak

SELECT * 
  FROM Countries
ORDER BY CountryCode, [Population] DESC