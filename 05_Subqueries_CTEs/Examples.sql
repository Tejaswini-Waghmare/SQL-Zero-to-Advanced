-- Module 05: Subqueries & CTEs
-- Run after setup.sql. Each example is standalone.

-- 1. CTE basics
WITH expensive AS (SELECT * FROM products WHERE list_price>150) SELECT COUNT(*) FROM expensive;

-- 2. Subquery IN
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE status='completed');

-- 3. EXISTS
SELECT c.customer_id FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);

-- 4. Correlated subquery
SELECT p.* FROM products p WHERE p.list_price > (SELECT AVG(p2.list_price) FROM products p2 WHERE p2.category=p.category);

-- 5. Two CTEs
WITH a AS (SELECT customer_id,COUNT(*) n FROM orders GROUP BY 1), b AS (SELECT AVG(n) avg_n FROM a) SELECT * FROM b;

-- 6. Scalar subquery
SELECT product_name,list_price,(SELECT AVG(list_price) FROM products) AS overall_avg FROM products;

-- 7. NOT EXISTS
SELECT c.customer_id FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);

-- 8. CTE revenue
WITH totals AS (SELECT order_id,SUM(quantity*unit_price) revenue FROM order_items GROUP BY order_id) SELECT AVG(revenue) FROM totals;
