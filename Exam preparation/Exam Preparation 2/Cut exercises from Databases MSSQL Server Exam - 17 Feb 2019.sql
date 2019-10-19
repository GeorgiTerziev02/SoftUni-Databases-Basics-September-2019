USE School

-- Exercise 6 change plus with coma
SELECT CONCAT(FirstName, ' ', MiddleName + ' ', LastName) AS [Full Name], [Address] 
  FROM Students
 WHERE [Address] LIKE '%road%'
ORDER BY FirstName, LastName, [Address]

-- Exercise 7
SELECT FirstName, [Address], Phone
  FROM Students
 WHERE MiddleName IS NOT NULL AND Phone LIKE '42%'
ORDER BY FirstName

-- Exercise 9
  SELECT CONCAT(t.FirstName, ' ', t.LastName) AS [FullName], 
         CONCAT(s.[Name], '-', s.Lessons) AS [Subjects], 
		 COUNT(st.StudentId) AS [Students]
    FROM Teachers t
    JOIN Subjects s ON t.SubjectId = s.Id
    JOIN StudentsTeachers st ON st.TeacherId = t.Id
GROUP BY t.FirstName, t.LastName, s.[Name], s.Lessons
ORDER BY Students DESC, FullName, Subjects

-- Exercise 11
  SELECT TOP(10) t.FirstName, t.LastName,  
		 COUNT(st.StudentId) AS [Students]
    FROM Teachers t
    JOIN StudentsTeachers st ON st.TeacherId = t.Id
GROUP BY t.FirstName, t.LastName
ORDER BY Students DESC, FirstName, LastName

-- Exercise 13
SELECT DISTINCT dt.FirstName, dt.LastName, dt.Grade 
FROM
	(SELECT s.FirstName, s.LastName, ss.Grade, ROW_NUMBER() OVER (PARTITION BY s.FirstName, s.LastName ORDER BY ss.Grade DESC) AS [Rank]
	FROM Students s
	JOIN StudentsSubjects ss ON s.Id = ss.StudentId) AS dt
WHERE dt.[Rank] = 2
ORDER BY dt.FirstName, dt.LastName

-- Exercise 15
SELECT dt.[Teacher Full Name], dt.SubjectName, dt.[Student Full Name], dt.Average
FROM(
SELECT s.Id,
       CONCAT(s.FirstName, ' ', s.LastName) AS [Student Full Name],
	   CONCAT(t.FirstName, ' ', t.LastName) AS [Teacher Full Name],
	   su.[Name] AS [SubjectName],
	   DENSE_RANK() OVER (PARTITION BY t.Id ORDER BY AVG(Grade) DESC) AS [Rank],
	   CAST(AVG(Grade) AS DECIMAL(3,2)) AS [Average]
  FROM Teachers t
    JOIN StudentsTeachers AS st ON st.TeacherId = t.Id
    JOIN Students AS s ON s.Id = st.StudentId
    JOIN StudentsSubjects AS ss ON ss.StudentId = s.Id
    JOIN Subjects AS su ON su.Id = ss.SubjectId AND su.Id = t.SubjectId
GROUP BY s.Id, s.FirstName, s.LastName, t.Id, t.FirstName, t.LastName, su.[Name]) AS dt
WHERE dt.[Rank] = 1
ORDER BY dt.[SubjectName], dt.[Teacher Full Name], dt.Average DESC

-- Exercise 17


-- Exercise 20
CREATE TABLE ExcludedStudents(
	StudentId INT,
	StudentName VARCHAR(50)
)

CREATE TRIGGER t_Exclude ON Students
AFTER DELETE
AS
BEGIN
	INSERT INTO ExcludedStudents (StudentId, StudentName)
	       SELECT Id, CONCAT(FirstName,  ' ', LastName) FROM deleted	
END

DELETE FROM StudentsExams
WHERE StudentId = 1

DELETE FROM StudentsTeachers
WHERE StudentId = 1

DELETE FROM StudentsSubjects
WHERE StudentId = 1

DELETE FROM Students
WHERE Id = 1

SELECT * FROM ExcludedStudents
