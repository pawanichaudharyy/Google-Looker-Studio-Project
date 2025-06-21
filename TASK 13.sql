                                            -- TASK 13
-- Show how much net profit each product category is generating — so the team can focus on the most profitable ones.

ALTER TABLE sku_detail
ADD COLUMN cogs DECIMAL(10,2);
UPDATE sku_detail
SET cogs = 500;
SELECT 
  sd.category,
  ROUND(SUM(od.totalamount - (sd.cogs * od.quantity)), 2) AS total_net_profit
FROM order_detail od
JOIN sku_detail sd ON od.sku_code = sd.sku_code
GROUP BY sd.category
ORDER BY total_net_profit DESC;


