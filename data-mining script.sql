-- create schema retailshop;
-- use retailshop;
-- select * from online_retail;

-- Define Metadata:
DESCRIBE online_retail;

-- Distribution of Order Values Across All Customers:
SELECT CustomerID, SUM(UnitPrice * Quantity) AS OrderValue
FROM online_retail
GROUP BY CustomerID;

-- Number of Unique Products Each Customer Purchased:
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProductsPurchased
FROM online_retail
GROUP BY CustomerID;

-- Customers Who Have Made Only One Purchase:
SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceNo) = 1;

-- Most Commonly Purchased Products Together:
SELECT a.StockCode AS Product1, b.StockCode AS Product2, COUNT(*) AS TimesPurchasedTogether
FROM online_retail a
JOIN online_retail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode < b.StockCode
GROUP BY Product1, Product2
ORDER BY TimesPurchasedTogether DESC
LIMIT 10;

-- Advanced Queries:
-- Customer Segmentation by Purchase Frequency:
SELECT CustomerID, 
       COUNT(DISTINCT InvoiceNo) AS TotalPurchases,
       CASE 
           WHEN COUNT(DISTINCT InvoiceNo) >= 20 THEN 'High Frequency'
           WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 10 AND 19 THEN 'Medium Frequency'
           ELSE 'Low Frequency'
       END AS PurchaseFrequencySegment
FROM online_retail
GROUP BY CustomerID;

-- Average Order Value by Country:
SELECT Country, AVG(UnitPrice * Quantity) AS AvgOrderValue
FROM online_retail
GROUP BY Country;

-- Customer Churn Analysis
SELECT CustomerID
FROM online_retail
WHERE InvoiceDate < CURDATE() - INTERVAL 6 MONTH
GROUP BY CustomerID;

-- Product Affinity Analysis:
SELECT a.StockCode AS Product1, b.StockCode AS Product2, COUNT(*) AS PurchaseTogether
FROM online_retail a
JOIN online_retail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode < b.StockCode
GROUP BY Product1, Product2
ORDER BY PurchaseTogether DESC;

-- Time-Based Analysis
SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(UnitPrice * Quantity) AS TotalSales
FROM online_retail
GROUP BY Year, Month
ORDER BY Year, Month;