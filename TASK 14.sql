                                            -- TASK 14
-- Understand how much sales are coming from different discount levels — e.g., no discount, low, medium, high. This helps marketing and pricing strategy.

SELECT 
  CASE 
    WHEN (price * quantity - totalamount) = 0 THEN 'No Discount'
    WHEN (price * quantity - totalamount) < 10 THEN 'Low Discount'
    WHEN (price * quantity - totalamount) BETWEEN 10 AND 20 THEN 'Medium Discount'
    ELSE 'High Discount'
  END AS discount_range,
  ROUND(SUM(price * quantity), 2) AS total_sales_before_discount
FROM order_detail
GROUP BY discount_range
ORDER BY total_sales_before_discount DESC;
