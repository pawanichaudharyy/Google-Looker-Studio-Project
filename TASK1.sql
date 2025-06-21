                                -- TASK-1 

-- Average Daily Sales (Weekends vs Weekdays) by Month (Q4 2022)


SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  CASE 
    WHEN DAYOFWEEK(order_date) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  ROUND(SUM(price * quantity) / COUNT(DISTINCT order_date), 2) AS avg_daily_sales
FROM order_detail
WHERE order_date BETWEEN '2022-10-01' AND '2022-12-31'
GROUP BY month, day_type
ORDER BY month, day_type;


-- Overall Average Sales in Q4 (Weekends vs Weekdays)
SELECT 
  CASE 
    WHEN DAYOFWEEK(order_date) IN (1,7) THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  ROUND(SUM(price * quantity) / COUNT(DISTINCT order_date), 2) AS avg_daily_sales
FROM order_detail
WHERE order_date BETWEEN '2022-10-01' AND '2022-12-31'
GROUP BY day_type;
