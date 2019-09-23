SELECT * FROM Customers

GO

CREATE VIEW v_PublicPaymentsInfo As
SELECT CustomerID,
       FirstName,
	   LastName,
	   CONCAT(LEFT(PaymentNumber, 6), REPLICATE('*', LEN(PaymentNumber) - 6))
	AS [Payment Number]  
  FROM Customers

GO

SELECT * FROM v_PublicPaymentsInfo

SELECT STUFF('This is a bad idea', 11, 3, 'good')

SELECT FORMAT(67.23, 'C',  'bg-BG')

SELECT FORMAT(67.23, 'C', 'de-DE')

SELECT FORMAT(0.76, 'P')

SELECT FORMAT(CAST('2019-01-21' AS date), 'D', 'bg-BG')

SELECT TRANSLATE('abcdefg', 'abcd', 'lmnu')

SELECT IIF(LEN(LastName) < 6, LastName, 'Too long') FROM Customers

SELECT PI()

SELECT Id, X1, X2, Y1, Y2,
       SQRT(SQUARE(X1-X2) + SQUARE(Y1-Y2))
	AS [Length]
  FROM Lines

SELECT ROUND(18.5679, 0)

SELECT * FROM Products

SELECT [Name], CEILING(CAST(CEILING(CAST(Quantity AS float)/BoxCapacity)/ PalletCapacity AS float)) AS Pallets FROM Products

SELECT SIGN(200), SIGN(0), SIGN(-20)

SELECT RAND()

SELECT DATEPART(WEEK,'2019-09-23')


USE SoftUni
SELECT * FROM Projects
 WHERE DATEPART(QUARTER, StartDate) = 3

USE Orders

SELECT 
       ProductName,
	   YEAR(OrderDate) AS [Year],
	   MONTH(OrderDate) AS [Month],
	   DAY(OrderDate) AS [Day],
	   DATEPART(QUARTER, OrderDate) AS [Quarter]
  FROM Orders

SELECT 
  DATEDIFF(SECOND, '2019-01-21T21:11:58', '2019-01-21T21:12:08')

USE SoftUni
  SELECT
      CONCAT_WS(', ', LastName, FirstName) AS [Employee],
	  DATEDIFF(year, HireDate, GETDATE()) AS [Years of service]
    FROM Employees
ORDER BY Employee

SELECT DATENAME(WEEKDAY, GETDATE())

SELECT HireDate,DATEADD(YEAR, 5, HireDate) 
    AS [EXP] 
  FROM Employees