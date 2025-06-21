                                              -- TASK 19
/* Find out how many customers made:

Only 1 purchase in 2022 ✅ (one-time buyers)

More than 1 purchase in 2022 ✅ (repeat customers)
Also, calculate the repeat customer ratio.  */

-- Step 1: Count orders per customer in 2022
WITH customer_orders_2022 AS (
  SELECT 
    customer_id,
    COUNT(DISTINCT order_id) AS num_orders
  FROM order_detail
  WHERE YEAR(order_date) = 2022
  GROUP BY customer_id
),

-- Step 2: Classify customers
customer_segments AS (
  SELECT 
    customer_id,
    CASE 
      WHEN num_orders = 1 THEN 'One-Time'
      ELSE 'Repeat'
    END AS customer_type
  FROM customer_orders_2022
)

-- Step 3: Count how many in each group
SELECT 
  customer_type,
  COUNT(*) AS customer_count
FROM customer_segments
GROUP BY customer_type;

-- ratio
SELECT 
  ROUND(
    SUM(CASE WHEN num_orders > 1 THEN 1 ELSE 0 END) / COUNT(*), 2
  ) AS repeat_customer_ratio
FROM customer_orders_2022;
