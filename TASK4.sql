                                                      -- TASK4
                                                      
-- Identify customers who started the checkout (is_gross = 1) but didn’t complete payment (is_valid = 0 and is_net = 0) in the year 2022.

SELECT DISTINCT 
  od.customer_id,
  cd.registered_date
FROM order_detail od
JOIN customer_detail cd ON od.customer_id = cd.id
WHERE YEAR(od.order_date) = 2022
  AND od.is_active = 1
  AND od.is_cancelled = 1
  AND od.totalamount = 0;
