--Задача 1 : Извлечете всички поръчки за клиентите, които са направили поръчки през януари и февруари 2024 и чиято стойност е между 100 и 300.

		SELECT CustomerID, OrderDate -- Селектираме къстъмър ID и дата на ордъра
		FROM Orders -- от таблица ордърс
		WHERE (OrderDate BETWEEN '2024-01-01' AND DATEADD(DAY, -1, '2024-03-01')) -- Където ордър дата е между 1-ви януари 2024г. края на февруари (използвано е DATEADD DAY - 1,
--понеже може да решим да сменим годината от високосна към не-високосна. Вадим 1 ден от 1-ви март.
		AND TotalAmount BETWEEN 100 AND 300 -- тотал амаунт е между 100 и 300



			
--Задача 2 : 
--Извлечете топ 5 клиентите, които са направили най-голям брой поръчки през 2024.
--За всеки клиент покажете неговото име, общия брой на поръчките и общата стойност на всички поръчки.

WITH 
	Group_Clients_From_Orders AS 
	(
		SELECT TOP(5) CustomerID, Count(OrderID) AS OrderCount, SUM(TotalAmount) as [Total_Amount_OF_Orders]
		FROM Orders
		WHERE OrderDate >= '2024-01-01'
		GROUP BY CustomerID
		ORDER BY OrderCount DESC
	
	)
	SELECT c.CustomerID, c.FirstName, c.LastName, ISNULL(o.OrderCount, 0) AS ORDCNT, ISNULL(Total_Amount_OF_Orders, 0) AS TOT_AM_CNT 
	FROM Group_Clients_From_Orders o 
	INNER JOIN Customers c ON c.customerID = o.CustomerID


--3. Намери всички клиенти, които са направили поръчки само през януари и март 2024 г., но не и през февруари.

		SELECT o.CustomerID, o.OrderDate, o.TotalAmount, c.firstName, c.LastName
		FROM Orders o 
		inner join Customers c ON o.CustomerID = c.CustomerID 
		WHERE (YEAR(o.OrderDate) = '2024' AND MONTH(o.OrderDate) = 1 
			 OR YEAR(o.OrderDate) = '2024' AND MONTH(o.OrderDate) = 3)
			 AND NOT EXISTS (
								SELECT 1 
								FROM Orders o2
								WHERE o.CustomerID = o2.CustomerID
								    AND YEAR(o.OrderDate) = '2024' AND MONTH(o.OrderDate) = 2
							)
		ORDER BY o.OrderDate ASC;

--4. Групирай поръчките по месеци и изчисли общата сума на поръчките за всеки месец.

SELECT YEAR(OrderDate) as [Year],  DATENAME(MONTH, OrderDate) AS [Month], SUM(TotalAmount) AS [Total_Amount]
FROM Orders 
GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY YEAR(OrderDate) DESC, MONTH(OrderDate)

--5. Месец с най-много клиенти:
--Намери месеца, в който са поръчвали най-много уникални клиенти.
	
	WITH 
	ORDER_BY_MONTH 
	AS
	(
	SELECT 
		  MONTH(o.OrderDate) as [month],
		  count(distinct CustomerID) AS UNIQU
	FROM Orders o
        GROUP BY MONTH(o.OrderDate)
	)
	SELECT *
	FROM ORDER_BY_MONTH
	WHERE UNIQU = (SELECT MAX(UNIQU) from ORDER_BY_MONTH)

