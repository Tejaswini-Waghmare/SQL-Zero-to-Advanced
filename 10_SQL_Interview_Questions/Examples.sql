-- Module 10: SQL Interview Questions
-- Run after setup.sql. Each example is standalone.

-- 1. Second most expensive
SELECT * FROM (SELECT *,DENSE_RANK() OVER(ORDER BY list_price DESC) r FROM products) x WHERE r=2;

-- 2. Latest per customer
SELECT DISTINCT ON(customer_id) customer_id,order_id,order_date FROM orders ORDER BY customer_id,order_date DESC,order_id DESC;

-- 3. Duplicate check
SELECT customer_id,order_date,COUNT(*) n FROM orders GROUP BY 1,2 HAVING COUNT(*)>1;

-- 4. Top 2 per category
SELECT * FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY category ORDER BY list_price DESC,product_id) r FROM products) x WHERE r<=2;

-- 5. Gaps between orders
SELECT customer_id,order_date-LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date,order_id) AS days_gap FROM orders LIMIT 30;

-- 6. Customers without orders
SELECT c.customer_id FROM customers c WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);

-- 7. Running total
WITH daily AS (SELECT order_date,COUNT(*) n FROM orders GROUP BY 1) SELECT order_date,n,SUM(n) OVER(ORDER BY order_date) running_n FROM daily ORDER BY order_date;

-- 8. Median price
SELECT PERCENTILE_CONT(.5) WITHIN GROUP(ORDER BY list_price) FROM products;
