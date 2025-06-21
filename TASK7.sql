                                                     -- TASK 7
-- Identify the top 20 products in the "Others" category that had the largest drop in sales quantity from 2021 to 2022, calculate percentage change, and classify the performance as UP, DOWN, or FAIR.

-- Step 1: Create sales totals by product for each year
WITH sales_2021 AS (
  SELECT od.sku_code, SUM(od.quantity) AS qty_2021
  FROM order_detail od
  JOIN sku_detail sd ON od.sku_code = sd.sku_code
  WHERE YEAR(od.order_date) = 2021 AND sd.category = 'Others'
  GROUP BY od.sku_code
),
sales_2022 AS (
  SELECT od.sku_code, SUM(od.quantity) AS qty_2022
  FROM order_detail od
  JOIN sku_detail sd ON od.sku_code = sd.sku_code
  WHERE YEAR(od.order_date) = 2022 AND sd.category = 'Others'
  GROUP BY od.sku_code
)

-- Step 2: Compare 2021 vs 2022, calculate drop and label
SELECT 
  sd.product_name,
  s21.qty_2021,
  s22.qty_2022,
  (COALESCE(s22.qty_2022, 0) - COALESCE(s21.qty_2021, 0)) AS qty_diff,
  ROUND(((COALESCE(s22.qty_2022, 0) - COALESCE(s21.qty_2021, 0)) / s21.qty_2021) * 100, 2) AS percent_change,
  CASE
    WHEN ((COALESCE(s22.qty_2022, 0) - COALESCE(s21.qty_2021, 0)) / s21.qty_2021) * 100 < -10 THEN 'DOWN'
    WHEN ((COALESCE(s22.qty_2022, 0) - COALESCE(s21.qty_2021, 0)) / s21.qty_2021) * 100 > 10 THEN 'UP'
    ELSE 'FAIR'
  END AS performance_status
FROM sales_2021 s21
LEFT JOIN sales_2022 s22 ON s21.sku_code = s22.sku_code
JOIN sku_detail sd ON s21.sku_code = sd.sku_code
ORDER BY qty_diff ASC
LIMIT 20;
