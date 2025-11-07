-- Check if there are any patterns for cancelled orders
SELECT 
    country,
    SUM(unitprice) AS total_cancelled_value,
    COUNT(*) AS orders_made
FROM ecommerce_cancelled
GROUP BY 
    country
ORDER BY 
	total_cancelled_value DESC;


SELECT *
FROM ecommerce_cancelled 