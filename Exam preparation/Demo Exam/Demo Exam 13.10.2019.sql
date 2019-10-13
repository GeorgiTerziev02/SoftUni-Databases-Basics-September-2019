CREATE DATABASE Bitbucket

USE Bitbucket

CREATE TABLE Users(
	Id INT PRIMARY KEY IDENTITY,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(30) NOT NULL,
	Email VARCHAR(50) NOT NULL
)

CREATE TABLE Repositories(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE RepositoriesContributors(
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id),
	ContributorId INT FOREIGN KEY REFERENCES Users(Id),
	CONSTRAINT PK_RepositoriesContributors
	PRIMARY KEY (RepositoryId, ContributorId)
) 

CREATE TABLE Issues(
	Id INT PRIMARY KEY IDENTITY,
	Title VARCHAR(255) NOT NULL,
	IssueStatus CHAR(6) NOT NULL,
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id),
	AssigneeId INT FOREIGN KEY REFERENCES Users(Id)
)

CREATE TABLE Commits(
	Id INT PRIMARY KEY IDENTITY,
	[Message] VARCHAR(255) NOT NULL,
	IssueId INT FOREIGN KEY REFERENCES Issues(Id),
	RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
	ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
)

CREATE TABLE Files(
	Id INT PRIMARY KEY IDENTITY,
	[Name] VARCHAR(100) NOT NULL,
	Size DECIMAL(18, 2) NOT NULL,
	ParentId INT FOREIGN KEY REFERENCES Files(Id),
	CommitId INT FOREIGN KEY REFERENCES Commits(Id)
)

-- Exercise 2
INSERT INTO Files ([Name], Size, ParentId, CommitId) VALUES
('Trade.idk', 2598.0, 1, 1),
('menu.net', 9238.31,	2,	2),
('Administrate.soshy', 1246.93,	3,	3),
('Controller.php', 7353.15,	4,	4),
('Find.java', 9957.86	,5,	5),
('Controller.json', 14034.87,	3,	6),
('Operate.xix', 7662.92,	7,	7)

INSERT INTO Issues (Title, IssueStatus, RepositoryId, AssigneeId) VALUES
('Critical Problem with HomeController.cs file', 'open', 1, 4),
('Typo fix in Judge.html', 'open', 4, 3),
('Implement documentation for UsersService.cs', 'closed', 8, 2),
('Unreachable code in Index.cs', 'open', 9, 8) 

-- Exercise 3
UPDATE Issues
SET IssueStatus = 'closed'
WHERE AssigneeId = 6

-- Exercise 4
DELETE FROM Issues
WHERE RepositoryId IN (
	SELECT Id FROM Repositories
	WHERE [Name] = 'Softuni-Teamwork'
)

DELETE FROM RepositoriesContributors
WHERE RepositoryId IN (
	SELECT Id FROM Repositories
	WHERE [Name] = 'Softuni-Teamwork'
)

-- Exercise 5
  SELECT Id, [Message], RepositoryId, ContributorId
    FROM Commits
ORDER BY Id, [Message], RepositoryId, ContributorId

-- Exercise 6
  SELECT Id, [Name], Size
    FROM Files f
   WHERE f.Size > 1000 AND f.[Name] LIKE '%html%'
ORDER BY f.Size DESC, f.Id, f.[Name]

-- Exercise 7
SELECT i.Id, CONCAT(u.Username, ' : ', i.Title) AS [IssueAssignee]
  FROM Issues i
  JOIN Users u ON i.AssigneeId = u.Id 
ORDER BY i.Id DESC, [IssueAssignee]

-- Exercise 8
   SELECT f1.Id, f1.[Name], CONCAT(f1.Size, 'KB') AS [Size]
     FROM Files f1
LEFT JOIN Files f2 ON f1.Id = f2.ParentId
    WHERE f2.ParentId IS NULL
 ORDER BY f1.Id, f1.[Name], f1.Size DESC


-- Exercise 9
SELECT TOP(5) r.Id, r.[Name], dt.Commits  FROM (SELECT COUNT(Id) AS [Commits], rc.RepositoryId
  FROM Commits c
  JOIN RepositoriesContributors rc ON c.RepositoryId = rc.RepositoryId
GROUP BY rc.RepositoryId) AS dt
  JOIN Repositories r ON dt.RepositoryId = r.Id
ORDER BY dt.Commits DESC, r.Id, r.[Name]


-- Exercise 10
  SELECT u.Username, AVG(f.Size) AS [Size]
    FROM Commits c
    JOIN Users u ON c.ContributorId = u.Id
    JOIN Files f ON f.CommitId = c.Id
GROUP BY u.Username
ORDER BY Size DESC, u.Username


-- Exercise 11
CREATE FUNCTION udf_UserTotalCommits(@username VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @commits INT =
	(SELECT COUNT(*) AS [Commits]
	  FROM Users u
	  JOIN Commits c ON u.Id = c.ContributorId
	 WHERE u.Username = @username)

	 RETURN @commits
END

SELECT dbo.udf_UserTotalCommits('UnderSinduxrein')

-- Exercise 12
CREATE PROCEDURE usp_FindByExtension(@extension VARCHAR(MAX))
AS
BEGIN
	SELECT f.Id, f.[Name], CONCAT(f.Size, 'KB') AS [Size]
	  FROM Files f
	 WHERE f.[Name] LIKE '%' + @extension
  ORDER BY f.Id, f.[Name], f.Size DESC

END

EXEC usp_FindByExtension 'txt'