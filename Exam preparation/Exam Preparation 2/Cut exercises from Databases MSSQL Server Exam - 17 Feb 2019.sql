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



-- Exercise 13



-- Exercise 15


-- Exercise 17


-- Exercise 20
