CREATE DATABASE Movies

CREATE TABLE Directors(
    Id INT PRIMARY KEY IDENTITY(1,1),
	DirectorName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName, Notes) VALUES
    ('Ivan', 'Funny'),
	('Sasho', 'Cringe'),
	('Gosho', 'Sad'),
	('Pesho', 'Notesss'),
	('Aleksasho', 'ALABALA')

--SELECT * FROM Directors

CREATE TABLE Genres(
    Id INT PRIMARY KEY IDENTITY(1,1),
	GenreName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Genres(GenreName, Notes) VALUES
    ('Action', 'Funny'),
	('Cartoon', 'Cringe'),
	('Thriller', 'Scary'),
	('Cars', 'Notesss'),
	('Sci-fi', 'interesting')

--SELECT * FROM Genres

CREATE TABLE Categories(
    Id INT PRIMARY KEY IDENTITY(1,1),
	CategoryName NVARCHAR(50) NOT NULL,
	Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName, Notes) VALUES
    ('Male', NULL),
	('Female', 'Cringe'),
	('Gender', NULL),
	('2019', NULL),
	('LAKA', 'interesting')

--SELECT * FROM Categories

CREATE TABLE Movies(
    Id INT PRIMARY KEY NOT NULL,
	Title NVARCHAR(200) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear INT,
	[Length] INT,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating INT,
	Notes NVARCHAR(MAX)
)

INSERT INTO Movies(Id, Title, DirectorId, GenreId, CategoryId) VALUES
    (1, 'It', 1, 2, 3),
	(2, 'Django', 3, 4, 3),
	(3, 'ALL', 4, 5, 3),
	(4, 'Interstellar', 2, 3, 3),
	(5, 'Genesis', 3, 5, 3)

SELECT * FROM Movies