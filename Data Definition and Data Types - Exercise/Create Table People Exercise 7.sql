USE Minions

CREATE TABLE People(
   Id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
   [Name] NVARCHAR(200) NOT NULL,
   Picture IMAGE,
   Height DECIMAL(15,2),
   [Weight] DECIMAL(15,2),
   Gender CHAR(1) NOT NULL,
   Birthdate SMALLDATETIME NOT NULL,
   Biography NVARCHAR(MAX)
)

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthdate, Biography) VALUES
('Ivan', NULL, 23.55, 55.3, 'f', CONVERT(datetime, '02-01-2001', 103), 'blo'),
('Ivancho', NULL, 24.65, 45.3, 'm', CONVERT(datetime, '02-01-2005', 103), 'b989'),
('Ivana', NULL, 32.85, 65.3, 'f', CONVERT(datetime, '02-01-2004', 103), 'bUUTYTT'),
('Sasho', NULL, 52.55, 75.3, 'm', CONVERT(datetime, '02-01-2002', 103), 'b'),
('Ivanka', NULL, 62.55, 85.3, 'f', CONVERT(datetime, '02-01-2003', 103), 'bTT')

SELECT * FROM People