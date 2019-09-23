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