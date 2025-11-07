-- Seasonality & Marketing Spend Optimization

SELECT 
  TO_CHAR(DATE_TRUNC('month', invoicedate::timestamp), 'YYYY-MM') AS month,
  ROUND(SUM(quantity * unitprice)::NUMERIC, 2) AS total_revenue,
  ROUND((SUM(quantity * unitprice) * 0.65)::NUMERIC, 2) AS est_gross_profit
FROM ecommerce_completed
GROUP BY month
ORDER BY month;
