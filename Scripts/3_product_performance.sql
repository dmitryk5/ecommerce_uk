-- Products Generating the Highest Gross Margin

SELECT 
  stockcode,
  description,
  SUM(quantity) AS total_sold,
  ROUND(SUM(quantity * unitprice)::NUMERIC, 2) AS total_revenue,
  ROUND((SUM(quantity * unitprice) * 0.65)::NUMERIC, 2) AS est_gross_profit
FROM ecommerce_completed
GROUP BY stockcode, description
ORDER BY est_gross_profit DESC
LIMIT 10;
