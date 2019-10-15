CREATE DATABASE School

USE School

CREATE TABLE Students(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(25),
	LastName NVARCHAR(30) NOT NULL,
	Age INT, --CHECK (Age Between 5 AND 100),
	CONSTRAINT Check_AgeBetween5And100 CHECK (Age BETWEEN 5 AND 100),
	[Address] NVARCHAR(50),
	Phone NCHAR(10)
)

CREATE TABLE Subjects(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(20) NOT NULL,
	Lessons INT CHECK(Lessons > 0) NOT NULL,
)

CREATE TABLE StudentsSubjects(
	Id INT PRIMARY KEY IDENTITY,
	StudentId INT FOREIGN KEY REFERENCES Students(Id) NOT NULL,
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id) NOT NULL,
	Grade DECIMAL(3, 2) CHECK (Grade BETWEEN 2 AND 6) NOT NULL
)

CREATE TABLE Exams(
	Id INT PRIMARY KEY IDENTITY,
	[Date] DATETIME2,
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id) NOT NULL
)

CREATE TABLE StudentsExams(
	StudentId INT FOREIGN KEY REFERENCES Students(Id) NOT NULL,
	ExamId INT FOREIGN KEY REFERENCES Exams(Id) NOT NULL,
	Grade DECIMAL(3, 2) CHECK (Grade BETWEEN 2 AND 6) NOT NULL,
	CONSTRAINT PK_CompositeStudentIdExamId 
	PRIMARY KEY (StudentId, ExamId)
)

CREATE TABLE Teachers(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(20) NOT NULL,
	LastName NVARCHAR(20) NOT NULL,
	[Address] NVARCHAR(20) NOT NULL,
	Phone CHAR(10),
	SubjectId INT FOREIGN KEY REFERENCES Subjects(Id) NOT NULL
)

CREATE TABLE StudentsTeachers(
	StudentId INT FOREIGN KEY REFERENCES Students(Id) NOT NULL,
	TeacherId INT FOREIGN KEY REFERENCES Teachers(Id) NOT NULL,
	CONSTRAINT PK_CompositeStudentIdTeacherId
	PRIMARY KEY(StudentId, TeacherId)
)

-- Exercise 2
INSERT INTO Teachers (FirstName, LastName, [Address], Phone, SubjectId) VALUES
	('Ruthanne',	'Bamb',	'84948 Mesta Junction',	'3105500146',	6),
	('Gerrard',	'Lowin',	'370 Talisman Plaza',	'3324874824',	2),
	('Merrile',	'Lambdin',	'81 Dahle Plaza',	'4373065154',	5),
	('Bert',	'Ivie',	'2 Gateway Circle',	'4409584510',	4)

INSERT INTO Subjects ([Name], Lessons) VALUES
	('Geometry', 12),
	('Health', 10),
	('Drama', 7),
	('Sports', 9)

-- Exercise 3
UPDATE StudentsSubjects
SET Grade = 6.00
WHERE SubjectId BETWEEN 1 AND 2 AND Grade >= 5.50

-- Exercise 4
DELETE FROM StudentsTeachers
WHERE TeacherId IN ( 
	SELECT Id 
	FROM Teachers 
	WHERE Phone LIKE '%72%')

DELETE FROM Teachers
WHERE CHARINDEX('72', Phone) > 0

-- Exercise 5
  SELECT FirstName, LastName, Age 
    FROM Students
   WHERE Age >= 12
ORDER BY FirstName, LastName

-- Exercise 6
   SELECT s.FirstName, s.LastName, COUNT(st.TeacherId) AS [TeachersCount]
     FROM Students s
LEFT JOIN StudentsTeachers st ON s.Id = st.StudentId 
 GROUP BY s.FirstName, s.LastName

-- Exercise 7
   SELECT CONCAT(s.FirstName,' ', s.LastName) AS [Full Name]
     FROM Students s
LEFT JOIN StudentsExams se ON s.Id = se.StudentId
    WHERE se.ExamId IS NULL
 ORDER BY [Full Name]

-- Exercise 8
  SELECT TOP(10) s.FirstName, s.LastName, CAST(AVG(se.Grade) AS DECIMAL(3,2)) AS [Grade]
    FROM Students s
	JOIN StudentsExams se ON s.Id = se.StudentId
GROUP BY s.FirstName, s.LastName
ORDER BY Grade DESC, s.FirstName, s.LastName

-- Exercise 9
   SELECT CONCAT(s.FirstName,' ', s.MiddleName + ' ', s.LastName) AS [Full Name]
     FROM Students s
LEFT JOIN StudentsSubjects ss ON s.Id = ss.StudentId
    WHERE ss.SubjectId IS NULL
 ORDER BY [Full Name]

-- Exercise 10
  SELECT s.[Name], AVG(ss.Grade)
    FROM Subjects s
    JOIN StudentsSubjects ss ON s.Id = ss.SubjectId
GROUP BY s.[Name], s.Id
ORDER BY s.Id 

-- Exercise 11
CREATE FUNCTION udf_ExamGradesToUpdate(@studentId INT, @grade DECIMAL(3, 2))
RETURNS NVARCHAR(100)
AS
BEGIN
	DECLARE @student NVARCHAR(50) = (
							SELECT TOP(1) s.FirstName
							FROM Students s
							WHERE Id = @studentId)
	IF(@student IS NULL) 
	BEGIN 
		RETURN 'The student with provided id does not exist in the school!'
	END
	IF(@grade > 6.00)
	BEGIN
		RETURN 'Grade cannot be above 6.00!'
	END

	DECLARE @count INT = (
						  SELECT COUNT(*)
						    FROM StudentsExams se
						   WHERE se.StudentId = @studentId AND se.Grade > @grade AND se.Grade <= @grade + 0.5	
						   )
	RETURN CONCAT('You have to update ', @count, ' grades for the student ', @student)
END

SELECT dbo.udf_ExamGradesToUpdate(12, 6.20)

SELECT dbo.udf_ExamGradesToUpdate(12, 5.50)

SELECT dbo.udf_ExamGradesToUpdate(121, 5.50)

-- Exercise 12
CREATE PROCEDURE usp_ExcludeFromSchool(@StudentId INT)
AS
BEGIN
	DECLARE @student INT = (SELECT TOP(1) Id FROM Students WHERE @StudentId = Id)

	IF(@student IS NULL)
	BEGIN
		RAISERROR('This school has no student with the provided id!', 16, 1)
		RETURN
	END

END