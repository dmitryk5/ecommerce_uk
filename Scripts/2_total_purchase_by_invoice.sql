-- Top 10% Customers

WITH customer_revenue AS (
    SELECT 
        customerid,
        ROUND(SUM(quantity * unitprice)::NUMERIC, 2) AS total_spent,
        COUNT(DISTINCT invoiceno) AS total_orders
    FROM ecommerce_completed
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
percentile_cutoff AS (
    SELECT 
        PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY total_spent) AS top_10_cutoff
    FROM customer_revenue
)
SELECT 
    c.customerid,
    c.total_spent,
    c.total_orders
FROM customer_revenue c
CROSS JOIN percentile_cutoff p
WHERE c.total_spent >= p.top_10_cutoff
ORDER BY c.total_spent DESC;

