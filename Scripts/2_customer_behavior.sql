-- Customer Loyalty and Churn Risk

WITH customer_stats AS (
    SELECT 
        customerid,
        COUNT(DISTINCT invoiceno) AS total_orders,
        SUM(quantity * unitprice) AS total_spent,
        MAX(invoicedate::date) AS last_purchase_date
    FROM ecommerce_completed
    WHERE customerid IS NOT NULL
    GROUP BY customerid
),
max_date AS (
    SELECT MAX(invoicedate::date) AS dataset_end_date
    FROM ecommerce_completed
)
SELECT 
    c.customerid,
    c.total_orders,
    ROUND(c.total_spent::NUMERIC, 2) AS total_spent,
    c.last_purchase_date,
    (m.dataset_end_date - c.last_purchase_date) AS days_since_last_purchase,
    CASE 
        WHEN (m.dataset_end_date - c.last_purchase_date) > 180 THEN 'At Risk'
        WHEN (m.dataset_end_date - c.last_purchase_date) BETWEEN 90 AND 180 THEN 'Passive'
        ELSE 'Active'
    END AS churn_status
FROM customer_stats c
CROSS JOIN max_date m
ORDER BY total_spent DESC;

