USE Insight_Mart_Analytics
GO

--1. What is the total Sales?
SELECT DC.[Customer Name],
		DP.[Product Name],
		SUM(FO.Sales) AS TOTAL_SALES
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
GROUP BY DC.[Customer Name],
		DP.[Product Name]
ORDER BY SUM(FO.Sales) DESC;


SELECT SUM(Sales) AS TOTAL_SALES
FROM Fact_Orders$;

--2.What is the total Profit?
SELECT SUM(Profit) AS TOTAL_PROFIT
FROM Fact_Orders$;

--3. Which category generates the highest Sales AND PROFIT?
SELECT TOP 1 DP.Category, 
			MAX(FO.Sales) AS TOTAL_SALES,
			MAX(FO.Profit) AS TOTAL_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
GROUP BY DP.Category;

--4. Which product generates the highest Sales AND PROFIT?
SELECT TOP 1 DP.[Product Name], 
			MAX(FO.Sales) AS TOTAL_SALES,
			MAX(FO.Profit) AS TOTAL_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
GROUP BY DP.[Product Name];

--5. Which region generates the highest Sales?
SELECT TOP 1 DC.Region,
			MAX(FO.Sales) AS HIGHEST_SALE,
			MAX(FO.Profit) AS HIGHEST_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
GROUP BY DC.Region;

--6. Which state generates the highest Profit?
SELECT TOP 1 DC.State,
			MAX(FO.Sales) AS HIGHEST_SALE,
			MAX(FO.Profit) AS HIGHEST_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
GROUP BY DC.State;

--7.Who are the top 10 customers by Sales AND PROFIT ?
SELECT TOP 10 DC.[Customer Name],
			SUM(FO.Sales) AS TOTAL_SALE,
			SUM(FO.Profit) AS TOTAL_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
GROUP BY DC.[Customer Name]
ORDER BY SUM(FO.Sales) DESC,
		 SUM(FO.Profit) DESC;

--8. Which customer segment generates the highest Sales? 
SELECT TOP 1 DC.Segment,
			SUM(FO.Sales) AS TOTAL_SALE,
			SUM(FO.Profit) AS TOTAL_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
GROUP BY DC.Segment
ORDER BY SUM(FO.Sales) DESC,
		 SUM(FO.Profit) DESC;

--9. Which customer has the highest number of orders? 
SELECT TOP 3 DC.[Customer Name],
			COUNT(FO.[Order ID]) AS ORDER_COUNT
FROM Fact_Orders$ FO
		INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
GROUP BY DC.[Customer Name]
ORDER BY COUNT(FO.[Order ID]);

--10.Which product has the highest Quantity sold?
SELECT TOP 1 DP.[Product Name],
		SUM(FO.Quantity)
FROM Fact_Orders$ FO
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
GROUP BY DP.[Product Name];

--11.Which category has the highest Quantity?
SELECT TOP 1  DP.Category,
		MAX(FO.Quantity) AS HIGHEST_QTY
FROM Fact_Orders$ FO
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
GROUP BY DP.Category;

--11. How many orders has each salesperson handled?
SELECT DSALE.Salesperson,
		COUNT(DISTINCT FO.[Order ID]) AS ORDERS_HANDLED
FROM Fact_Orders$ FO
INNER JOIN Dim_Salesperson$ DSALE
		ON FO.[Salesperson ID]=DSALE.[Salesperson ID]
GROUP BY DSALE.Salesperson
ORDER BY COUNT(FO.[Order ID]) DESC;

--12. 22. What is the Sales and Profit for every region,CITY AND STATE?
SELECT DGEO.City,
		DGEO.Region,
		DGEO.State,
		ROUND(SUM(FO.Sales),2) AS TOTAL_SALES,
		ROUND(SUM(FO.Profit),2) AS TOTAL_PROFIT
FROM Fact_Orders$ FO
INNER JOIN Dim_Geography$ DGEO
		ON FO.[Geography ID]=DGEO.[Geography ID]
GROUP BY DGEO.City,
		DGEO.Region,
		DGEO.State
ORDER BY ROUND(SUM(FO.Sales),2) DESC,
		 ROUND(SUM(FO.Profit),2) DESC;









