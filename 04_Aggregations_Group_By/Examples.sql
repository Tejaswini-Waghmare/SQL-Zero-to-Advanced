-- Module 04: Aggregations & GROUP BY
-- Run after setup.sql. Each example is standalone.

-- 1. Group by city
SELECT city, COUNT(*) AS customers FROM customers GROUP BY city ORDER BY customers DESC;

-- 2. Average price
SELECT category,ROUND(AVG(list_price),2) AS avg_price FROM products GROUP BY category;

-- 3. HAVING
SELECT customer_id,COUNT(*) AS orders FROM orders GROUP BY customer_id HAVING COUNT(*)>=5;

-- 4. Conditional counts
SELECT COUNT(*) FILTER (WHERE status='completed') AS completed,COUNT(*) FILTER (WHERE status='cancelled') AS cancelled FROM orders;

-- 5. Revenue by region
SELECT o.region,SUM(oi.quantity*oi.unit_price) AS revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.region ORDER BY revenue DESC;

-- 6. Monthly orders
SELECT DATE_TRUNC('month',order_date)::date AS month,COUNT(*) FROM orders GROUP BY 1 ORDER BY 1;

-- 7. Min max
SELECT MIN(list_price),MAX(list_price) FROM products;

-- 8. Count distinct
SELECT COUNT(DISTINCT customer_id) FROM orders;
