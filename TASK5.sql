                                -- TASK 5
-- Identify products that had the largest drop in quantity sold from 2021 to 2022. Show the top 10.


-- Get sales quantity for each SKU in 2021
WITH sales_2021 AS (
  SELECT sku_code, SUM(quantity) AS qty_2021
  FROM order_detail
  WHERE YEAR(order_date) = 2021
  GROUP BY sku_code
),

-- Get sales quantity for each SKU in 2022
sales_2022 AS (
  SELECT sku_code, SUM(quantity) AS qty_2022
  FROM order_detail
  WHERE YEAR(order_date) = 2022
  GROUP BY sku_code
)

-- Compare 2021 and 2022 and find the biggest drops
SELECT 
  sd.product_name,
  COALESCE(s21.qty_2021, 0) AS qty_2021,
  COALESCE(s22.qty_2022, 0) AS qty_2022,
  (COALESCE(s22.qty_2022, 0) - COALESCE(s21.qty_2021, 0)) AS qty_difference
FROM sales_2021 s21
LEFT JOIN sales_2022 s22 ON s21.sku_code = s22.sku_code
JOIN sku_detail sd ON sd.sku_code = s21.sku_code
ORDER BY qty_difference ASC
LIMIT 10;
