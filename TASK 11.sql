                                                                -- TASK 11
-- Track the relationship between:
-- 1. Monthly sales growth
-- 2. Average monthly discount rate

WITH monthly_data AS (
  SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(price * quantity) AS before_discount,
    SUM(price * quantity - totalamount) AS discount_amount
  FROM order_detail
  WHERE order_date BETWEEN '2022-01-01' AND '2022-12-31'
  GROUP BY month
),

discount_rate_calc AS (
  SELECT 
    month,
    before_discount,
    discount_amount,
    ROUND(discount_amount / before_discount, 4) AS avg_discount_rate
  FROM monthly_data
),

sales_growth_calc AS (
  SELECT 
    a.month,
    a.before_discount,
    a.avg_discount_rate,
    ROUND((a.before_discount - b.before_discount) / b.before_discount, 4) AS sales_growth
  FROM discount_rate_calc a
  LEFT JOIN discount_rate_calc b 
    ON DATE_FORMAT(a.month, '%Y-%m') = DATE_FORMAT(DATE_ADD(b.month, INTERVAL 1 MONTH), '%Y-%m')
)

SELECT * FROM sales_growth_calc
ORDER BY month;
