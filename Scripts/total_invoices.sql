-- Invoices (541,909)

SELECT 
	COUNT(invoiceno) AS count_invoices
FROM
ecommerce_uk ;

-- Cancelled Invoices (9,288)
SELECT 
    COUNT(CASE WHEN invoiceno LIKE 'C%' THEN 1 END) AS count_cancelled_invoices
FROM ecommerce_uk;

-- Total Completed Invoices (532,621)
SELECT 
	(COUNT(invoiceno) - COUNT(CASE WHEN invoiceno LIKE 'C%' THEN 1 END)) AS total_completed_invoices
FROM ecommerce_uk;

-- Percentage of Orders Cancelled (1.71%)
SELECT
    ROUND(COUNT(CASE WHEN invoiceno LIKE 'C%' THEN 1 END) * 100.0 / COUNT(invoiceno)::NUMERIC, 2) AS pct_cancelled
FROM ecommerce_uk;

-- Create a new table with just the completed invoices -- INCORRECT VALUES
CREATE TABLE ecommerce_completed AS
SELECT *
FROM ecommerce_uk
WHERE REPLACE(invoiceno, 'C', '') NOT IN (
    SELECT DISTINCT REPLACE(invoiceno, 'C', '')
    FROM ecommerce_uk
    WHERE invoiceno LIKE 'C%'
);

-- Create a new table with only cancelled invoices 
CREATE TABLE ecommerce_cancelled AS
SELECT *
FROM ecommerce_uk
WHERE invoiceno LIKE 'C%';


