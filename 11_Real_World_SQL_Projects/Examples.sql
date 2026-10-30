-- Module 11: Real-World SQL Projects
-- Run after setup.sql. Each example is standalone.

-- 1. Project 1 regional sales
SELECT o.region,p.category,ROUND(SUM(oi.quantity*oi.unit_price),2) revenue FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id) WHERE o.status='completed' GROUP BY 1,2 ORDER BY revenue DESC;

-- 2. Project 1 channel orders
SELECT channel,status,COUNT(*) FROM orders GROUP BY 1,2 ORDER BY 1,2;

-- 3. Project 1 return rate
SELECT region,ROUND(100.0*COUNT(*) FILTER(WHERE status='returned')/COUNT(*),2) return_pct FROM orders GROUP BY 1;

-- 4. Project 2 customer cohorts
WITH firsts AS (SELECT customer_id,DATE_TRUNC('month',MIN(order_date))::date cohort FROM orders WHERE status='completed' GROUP BY 1) SELECT cohort,COUNT(*) customers FROM firsts GROUP BY 1 ORDER BY 1;

-- 5. Project 2 repeat purchase
SELECT COUNT(*) FILTER(WHERE n>=2) repeat_buyers,COUNT(*) total_buyers FROM (SELECT customer_id,COUNT(*) n FROM orders WHERE status='completed' GROUP BY 1) x;

-- 6. Project 2 purchase frequency
SELECT customer_id,COUNT(*) completed_orders FROM orders WHERE status='completed' GROUP BY 1 ORDER BY completed_orders DESC LIMIT 10;

-- 7. Project 3 product units
SELECT p.product_name,SUM(oi.quantity) units FROM order_items oi JOIN products p USING(product_id) JOIN orders o USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY units DESC;

-- 8. Project 3 demand proxy
SELECT p.category,COUNT(DISTINCT o.order_id) orders FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id) WHERE o.status='completed' GROUP BY 1 ORDER BY orders DESC;
