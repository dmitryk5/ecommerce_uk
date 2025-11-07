-- Cleaning the table. Making sure no cancelled values are included.

CREATE TABLE ecommerce_completed AS
SELECT *
FROM ecommerce_uk
WHERE invoiceno NOT LIKE 'C%'    -- remove cancelled
  AND invoiceno NOT LIKE 'A%'    -- remove special negative invoices
  AND quantity > 0                -- remove zero or negative quantities
  AND unitprice > 0; 

SELECT COUNT(*) AS total_rows,
       SUM(CASE WHEN quantity <= 0 OR unitprice <= 0 THEN 1 ELSE 0 END) AS zero_or_negative,
       SUM(CASE WHEN invoiceno LIKE 'C%' THEN 1 ELSE 0 END) AS cancelled,
       SUM(CASE WHEN invoiceno LIKE 'A%' THEN 1 ELSE 0 END) AS a_prefix
FROM ecommerce_completed;