                                                               -- TASK 18
-- Calculate how long it takes customers to place their first order after they register.

-- Step 1: Find first order date per customer
WITH first_orders AS (
  SELECT 
    customer_id,
    MIN(order_date) AS first_order_date
  FROM order_detail
  GROUP BY customer_id
)

-- Step 2: Join with registration date and calculate difference
SELECT 
  cd.id AS customer_id,
  cd.registered_date,
  fo.first_order_date,
  DATEDIFF(fo.first_order_date, cd.registered_date) AS days_to_first_order
FROM customer_detail cd
JOIN first_orders fo ON cd.id = fo.customer_id
WHERE fo.first_order_date IS NOT NULL;

SELECT 
  ROUND(AVG(DATEDIFF(fo.first_order_date, cd.registered_date)), 2) AS avg_days_to_first_order
FROM customer_detail cd
JOIN (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM order_detail
  GROUP BY customer_id
) fo ON cd.id = fo.customer_id;

-- Average Time to First Order (Single Value)
SELECT 
  ROUND(AVG(DATEDIFF(fo.first_order_date, cd.registered_date)), 2) AS avg_days_to_first_order
FROM customer_detail cd
JOIN (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM order_detail
  GROUP BY customer_id
) fo ON cd.id = fo.customer_id;
