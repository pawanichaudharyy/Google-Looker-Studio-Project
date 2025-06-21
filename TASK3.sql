                                    -- TASK 3
-- Help the marketing team identify which product category performed best over time during 2022.
SELECT 
  sd.category,
  DATE_FORMAT(od.order_date, '%Y-%m') AS month,
  SUM(od.quantity) AS total_units_sold
FROM order_detail od
JOIN sku_detail sd ON od.sku_code = sd.sku_code
WHERE YEAR(od.order_date) = 2022
GROUP BY sd.category, month
ORDER BY sd.category, month;
