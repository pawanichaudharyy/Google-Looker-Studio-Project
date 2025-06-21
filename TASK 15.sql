                                                           -- TASK 15
-- Understand how different payment methods perform in terms of:

--  1.Total Revenue (before discount)

-- 2. Quantity Sold

-- 3. Net Profit

SELECT 
  od.payment_type AS payment_method,
  ROUND(SUM(od.price * od.quantity), 2) AS total_sales_before_discount,
  SUM(od.quantity) AS total_quantity_sold,
  ROUND(SUM(od.totalamount - (sd.cogs * od.quantity)), 2) AS total_net_profit
FROM order_detail od
JOIN sku_detail sd ON od.sku_code = sd.sku_code
GROUP BY od.payment_type
ORDER BY total_sales_before_discount DESC;
