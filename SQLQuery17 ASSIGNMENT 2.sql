USE Insight_Mart_Analytics
GO

SELECT FO.[Order ID],
		DC.[Customer Name],
		DC.Segment,
		DP.[Product Name],
		DP.Category,
		DP.[Sub-Category],
		DGEO.Region,
		DGEO.State,
		DGEO.City,
		DSALE.Salesperson,
		FO.Quantity,
		FO.Sales,
		FO.Cost,
		FO.Profit,
		FO.Discount,
		DPAY.[Payment Mode],
		DPRIOR.[Order Priority],
		DRETURN.Returns,
		 CASE
        WHEN FO.Sales >= 50000 THEN 'HIGH'
        WHEN FO.Sales >= 25000 THEN 'MEDIUM'
        WHEN FO.Sales >= 10000 THEN 'AVERAGE'
        ELSE 'LOW'
    END AS [Sales Category],

    CASE
        WHEN FO.Profit >= 10000 THEN 'HIGH PROFIT'
        WHEN FO.Profit >= 5000 THEN 'MEDIUM PROFIT'
        WHEN FO.Profit >= 0 THEN 'LOW PROFIT'
        ELSE 'LOSS'
    END AS [Profit Category]
INTO SALES_REPORT
FROM Fact_Orders$ FO
INNER JOIN Dim_Customer$ DC
		ON FO.[Customer ID]=DC.[Customer ID]
INNER JOIN Dim_Product$ DP
		ON FO.[Product ID]=DP.[Product ID]
INNER JOIN Dim_Geography$ DGEO
		ON FO.[Geography ID]=DGEO.[Geography ID]
INNER JOIN Dim_Salesperson$ DSALE
		ON FO.[Salesperson ID]=DSALE.[Salesperson ID]
INNER JOIN Dim_Payment$ DPAY
		ON FO.[Payment Mode ID]=DPAY.[Payment Mode ID]
INNER JOIN Dim_Priority$ DPRIOR
		ON FO.[Priority ID]=DPRIOR.[Priority ID]
INNER JOIN Dim_Return$ DRETURN
		ON DRETURN.[Return ID]=FO.[Return ID]

--1.What are the top 10 orders by Sales? 

SELECT TOP 10 [Order ID],
			[Customer Name],
			SUM(Sales) AS TOTAL_SALES
FROM SALES_REPORT
GROUP BY [Order ID],
		[Customer Name]
ORDER BY TOTAL_SALES DESC;

--2.What are the top 10 orders by Profit?
SELECT TOP 10 [Order ID],
			[Customer Name],
			SUM(Profit) AS TOTAL_PROFIT
FROM SALES_REPORT
GROUP BY [Order ID],
			[Customer Name]
ORDER BY SUM(Profit) DESC;

--3.Which category generated the highest Sales?
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM SALES_REPORT
GROUP BY Category
ORDER BY SUM(Sales) DESC;

--4.Which region generated the highest Profit? 
SELECT TOP 1 Region,
		SUM(Profit) AS TOTAL_PROFIT,
		[Profit Category]
		
FROM SALES_REPORT
GROUP BY Region,[Profit Category]
ORDER BY SUM(Profit) DESC;

--5.Which salesperson generated the highest Sales?
SELECT TOP 5 Salesperson,
		SUM(Sales) AS TOTAL_SALES
		
FROM SALES_REPORT
GROUP BY Salesperson,
		[Sales Category]
ORDER BY SUM(Sales) DESC;

--6.Which customer generated the highest Sales? 
SELECT TOP 1
    [Customer Name],
    SUM(Sales) AS Total_Sales
FROM SALES_REPORT
GROUP BY [Customer Name]
ORDER BY SUM(Sales) DESC;

--7. Which product generated the highest Profit? 
SELECT TOP 1
    [Product Name],
    SUM(Profit) AS Total_Profit
FROM SALES_REPORT
GROUP BY [Product Name]
ORDER BY SUM(Profit) DESC;

--8. Which category has the highest returns? 
SELECT Category,
		COUNT(Returns) AS NO_OF_RETURNS
FROM SALES_REPORT
GROUP BY Category
ORDER BY COUNT(Returns) DESC;

--9. Which customers have Sales above the overall average Sales?
SELECT TOP 10 [Customer Name],
		SUM(Sales) AS TOTAL_SALES
FROM SALES_REPORT
GROUP BY [Customer Name]
HAVING SUM(Sales) > (
    SELECT AVG(Sales)
    FROM SALES_REPORT
)
ORDER BY SUM(Sales) DESC;