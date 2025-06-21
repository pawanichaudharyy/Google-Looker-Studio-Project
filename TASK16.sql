                                                -- TASK 16
-- Compare the total revenue before discount and after discount, and show the discount impact across product categories.

SELECT 
  sd.category,
  ROUND(SUM(od.price * od.quantity), 2) AS total_before_discount,
  ROUND(SUM(od.totalamount), 2) AS total_after_discount,
  ROUND(SUM(od.price * od.quantity - od.totalamount), 2) AS discount_impact
FROM order_detail od
JOIN sku_detail sd ON od.sku_code = sd.sku_code
GROUP BY sd.category
ORDER BY discount_impact DESC;
