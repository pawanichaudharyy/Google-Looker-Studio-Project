                                    -- TASK2

--  how the Average Order Value (AOV) changed month-over-month during 2022.


SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  ROUND(SUM(totalamount) / COUNT(DISTINCT order_id), 2) AS average_order_value
FROM order_detail
WHERE YEAR(order_date) = 2022
GROUP BY month
ORDER BY month;
