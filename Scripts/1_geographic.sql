-- Geographic
-- Check which country provides the most value AND Check average value per purchase **FINAL**
-- Assuming a 35% COGS (Cost of Goods Sold)
SELECT 
    country,
    ROUND(SUM(quantity * unitprice)::NUMERIC, 2) AS total_revenue,
    COUNT(DISTINCT invoiceno) AS total_orders,
    ROUND((SUM(quantity * unitprice)::NUMERIC / COUNT(DISTINCT invoiceno)), 2) AS avg_order_value,
    ROUND((SUM(quantity * unitprice)::NUMERIC * 0.65), 2) AS est_gross_profit
FROM ecommerce_completed
GROUP BY country
ORDER BY est_gross_profit DESC;

