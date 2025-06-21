                                                -- TASK 6
-- Identify the top 5 products in the "Mobiles & Tablets" category with the highest quantity sold in 2022, considering only valid orders.

SELECT 
  sd.product_name,
  sd.category,
  SUM(od.quantity) AS total_quantity_sold
FROM order_detail od
JOIN sku_detail sd ON od.sku_code = sd.sku_code
WHERE sd.category = 'Mobiles & Tablets'
  AND YEAR(od.order_date) = 2022
  AND od.is_active = 1
GROUP BY sd.product_name, sd.category
ORDER BY total_quantity_sold DESC
LIMIT 5;
