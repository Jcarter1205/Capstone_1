-- Emporium Capstone Project
-- Sales Analysis: Massachusetts (MA)
-- Assigned Territory Massachusetts
-- Region: Northeast

USE sample_sales;

-- Question 1: Total revenue and date range for Massachusetts

-- Total online revenue and date range for Massachusetts

SELECT
	SUM(SalesTotal) AS TotalRevenue,
	MIN(Date) AS EarliestOnlineDate,
    MAX(date) AS LatestOnlineDate
FROM online_sales
WHERE ShiptoState IN ('MA', 'Massachusetts');

-- Total in-store revenue and date range for Massachusetts

SELECT
	SUM(ss.Sale_Amount) AS InStoreRevenue,
    MIN(ss.Transaction_Date) AS EarliestStoreDate,
    MAX(ss.Transaction_Date) AS LatestStoreDate
FROM store_sales ss
JOIN store_locations sl
	ON ss.Store_ID = sl.StoreID
WHERE sl.State IN ('MA', 'Massachusetts');

-- Combined Massachusetts revenue and date range

SELECT
	SUM(Revenue) AS TotalRevenue,
    MIN(SalesDate) AS EarliestDate,
    MAX(SalesDate) AS LatestDate
FROM(
	SELECT
		SalesTotal AS Revenue,
        Date AS SalesDate
	FROM online_sales
    WHERE ShiptoState IN ('MA', 'Massachusetts')
	
    UNION ALL
    
    SELECT
		ss.Sale_Amount AS Revenue,
        ss.Transaction_Date AS SalesDate
	FROM store_sales AS ss
    INNER JOIN store_locations AS sl
		ON ss.Store_ID = sl.StoreId
	WHERE sl.State IN ('MA', 'Massachusetts')
) AS MassachusettsSales;       

-- Question 2: Revenue by Yar and Month for Massachusetts

SELECT
	YEAR(SalesDate) AS SalesYear,
    Month(SalesDate) AS SalesMonth,
    SUM(Revenue) AS TotalRevenue
FROM (
	SELECT
		SalesTotal AS Revenue,
        Date AS SalesDate
	FROM online_sales
    WHERE ShiptoState IN ('MA', 'Massachusetts')
    
    UNION ALL
    
    SELECT
		ss.Sale_Amount AS Revenue,
        ss.Transaction_Date AS SalesDate
	FROM store_sales AS ss
    INNER JOIN store_locations AS sl
		ON ss.Store_ID = sl.StoreId
	WHERE sl.State IN ('MA', 'Massachusetts')
) AS MassachusettsSales
GROUP BY
	YEAR(SalesDate),
    MONTH(SalesDate)
ORDER BY
	SalesYear,
	SalesMonth;
    
    -- Question 3: Massachusetts revenue compared with its region

SELECT
	State,
    Region,
    RegionalDirector,
    SalesManager
FROM management
Where State IN ('MA', 'Massachusetts');

SELECT
	State,
    Region
FROM management
WHERE Region = 'Northeast';

USE sample_sales;

WITH AllSales AS (
    -- Online sales grouped by state
    SELECT
        ShiptoState AS State,
        SUM(SalesTotal) AS Revenue
    FROM online_sales
    GROUP BY ShiptoState

    UNION ALL

    -- In-store sales grouped by state
    SELECT
        sl.State,
        SUM(ss.Sale_Amount) AS Revenue
    FROM store_sales AS ss
    INNER JOIN store_locations AS sl
        ON ss.Store_ID = sl.StoreId
    GROUP BY sl.State
),

StateRevenue AS (
    SELECT
        State,
        SUM(Revenue) AS TotalRevenue
    FROM AllSales
    GROUP BY State
),

RegionalComparison AS (
    SELECT
        SUM(
            CASE
                WHEN sr.State = 'Massachusetts'
                THEN sr.TotalRevenue
                ELSE 0
            END
        ) AS MassachusettsRevenue,

        SUM(sr.TotalRevenue) AS NortheastRevenue

    FROM StateRevenue AS sr
    INNER JOIN management AS m
        ON sr.State = m.State
    WHERE m.Region = 'Northeast'
)

SELECT
    MassachusettsRevenue,
    NortheastRevenue,
    NortheastRevenue - MassachusettsRevenue AS OtherRegionalRevenue,

    ROUND(
        MassachusettsRevenue / NULLIF(NortheastRevenue, 0) * 100,
        2
    ) AS MassachusettsPercentage

FROM RegionalComparison;

-- Massachusetts generated $9,832,788.26 out of the Northeast's
-- $32,846,960.65 total revenue, contributing 29.94%.

-- Question 4: Monthly Transactions and Average Sales by Product Category

SELECT
    YEAR(s.Transaction_Date) AS Sales_Year,
    MONTH(s.Transaction_Date) AS Sales_Month,
    c.Category AS Product_Category,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(s.Sale_Amount), 2) AS Average_Sale

FROM store_sales AS s

INNER JOIN store_locations AS l
    ON s.Store_ID = l.StoreId

INNER JOIN products AS p
    ON s.Prod_Num = p.ProdNum

INNER JOIN inventory_categories AS c
    ON p.Categoryid = c.Categoryid

WHERE l.State = 'Massachusetts'

GROUP BY
    Sales_Year,
    Sales_Month,
    Product_Category

ORDER BY
    Sales_Year,
    Sales_Month,
    Product_Category;
    
-- Question 5: Rank In-Store Sales Performace by Store in Massachusetts

SELECT
	sl.StoreId,
    sl.StoreLocation,
    sl.State,
    SUM(ss.Sale_Amount) AS TotalRevenue,
    RANK() OVER (
		ORDER BY SUM(ss.Sale_Amount) DESC
    ) AS StoreRank
FROM store_sales AS ss
INNER JOIN store_locations AS sl
		ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts'
GROUP BY
	sl.StoreId,
    sl.StoreLocation,
    sl.State
ORDER BY
	StoreRank;
    
-- Question 6: Recommendation for Next-Quarter Sales Focus
-- Based on the analysis of Massachusetts sales, EmporiUM should focus
-- on expanding sales of Technology and Accesories products. The results
-- show the Massachusetts generated $9,832,788.26 in revenue between
-- 2022-01-01 and 2025-12-31, and the Technology and Accesories had the
-- highest transaction count (112) and the highest average sale
-- $437.05. Massachusetts also contributes 29.94% of all Northeast
-- revenue, making it an import market for growth.
-- To improve next quarter performance, the company should increase
-- targeted promotions for Technology and Accesories products across
-- Massachusetts stores.