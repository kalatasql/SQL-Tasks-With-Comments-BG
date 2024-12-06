Задача : Извлечете всички поръчки за клиентите, които са направили поръчки през януари и февруари 2024 и чиято стойност е между 100 и 300.

		SELECT CustomerID, OrderDate -- Селектираме къстъмър ID и дата на ордъра
		FROM Orders -- от таблица ордърс
		WHERE (OrderDate BETWEEN '2024-01-01' AND DATEADD(DAY, -1, '2024-03-01')) -- Където ордър дата е между 1-ви януари 2024г. края на февруари (използвано е DATEADD DAY - 1,
--понеже може да решим да сменим годината от високосна към не-високосна. Вадим 1 ден от 1-ви март.
		AND TotalAmount BETWEEN 100 AND 300 -- тотал амаунт е между 100 и 300
	