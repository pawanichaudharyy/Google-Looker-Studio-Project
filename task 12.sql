									             -- task 12
-- Help the product team identify which categories sell the most on average per product — to spot overstock or underperforming items.

-- Step 1: Total quantity sold per product
WITH product_sales AS (
  SELECT 
    od.sku_code,
    sd.category,
    SUM(od.quantity) AS total_quantity_sold
  FROM order_detail od
  JOIN sku_detail sd ON od.sku_code = sd.sku_code
  GROUP BY od.sku_code, sd.category
)

-- Step 2: Average quantity per product in each category
SELECT 
  category,
  ROUND(AVG(total_quantity_sold), 2) AS avg_quantity_per_product
FROM product_sales
GROUP BY category
ORDER BY avg_quantity_per_product DESC;
