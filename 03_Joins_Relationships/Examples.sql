-- Module 03: Joins & Relationships
-- Run after setup.sql. Each example is standalone.

-- 1. Inner join
SELECT o.order_id, c.city FROM orders o JOIN customers c ON c.customer_id=o.customer_id LIMIT 10;

-- 2. Left join
SELECT c.customer_id, COUNT(o.order_id) AS order_count FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id GROUP BY c.customer_id ORDER BY c.customer_id;

-- 3. Three tables
SELECT o.order_id,p.category,oi.quantity FROM orders o JOIN order_items oi ON o.order_id=oi.order_id JOIN products p ON p.product_id=oi.product_id LIMIT 10;

-- 4. Unmatched records
SELECT c.customer_id FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id WHERE o.order_id IS NULL;

-- 5. Revenue by customer
SELECT o.customer_id, SUM(oi.quantity*oi.unit_price) AS gross_sales FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.customer_id ORDER BY gross_sales DESC LIMIT 10;

-- 6. Join validation
SELECT COUNT(*) AS rows_after_join FROM orders o JOIN order_items oi USING(order_id);

-- 7. Distinct join keys
SELECT COUNT(DISTINCT order_id) AS orders_with_items FROM order_items;

-- 8. Category sales
SELECT p.category,SUM(oi.quantity*oi.unit_price) AS revenue FROM order_items oi JOIN products p USING(product_id) JOIN orders o USING(order_id) WHERE o.status='completed' GROUP BY p.category ORDER BY revenue DESC;
