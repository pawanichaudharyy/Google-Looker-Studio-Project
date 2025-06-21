                                                         -- TASK 17
-- Group customers based on their total net profit contribution and classify them into:
-- 1. High
-- 2. Medium
-- 3. Low

-- Step 1: Compute net profit per customer
WITH customer_profit AS (
  SELECT 
    od.customer_id,
    ROUND(SUM(od.totalamount - (sd.cogs * od.quantity)), 2) AS total_net_profit
  FROM order_detail od
  JOIN sku_detail sd ON od.sku_code = sd.sku_code
  GROUP BY od.customer_id
)

-- Step 2: Segment customers based on total net profit
SELECT 
  CASE 
    WHEN total_net_profit < 100 THEN 'Low'
    WHEN total_net_profit BETWEEN 100 AND 500 THEN 'Medium'
    ELSE 'High'
  END AS profit_segment,
  COUNT(*) AS customer_count
FROM customer_profit
GROUP BY profit_segment
ORDER BY FIELD(profit_segment, 'High', 'Medium', 'Low');
