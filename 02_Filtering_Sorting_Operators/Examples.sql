-- Module 02: Filtering, Sorting & Operators
-- Run after setup.sql. Each example is standalone.

-- 1. Numeric filter
SELECT * FROM products WHERE list_price >= 100;

-- 2. IN list
SELECT * FROM customers WHERE city IN ('Atlanta','Austin');

-- 3. BETWEEN
SELECT * FROM products WHERE list_price BETWEEN 50 AND 200;

-- 4. LIKE
SELECT * FROM products WHERE product_name ILIKE '%a%';

-- 5. Boolean grouping
SELECT * FROM orders WHERE status = 'completed' AND (channel = 'web' OR channel = 'mobile');

-- 6. CASE labels
SELECT product_name, CASE WHEN list_price >= 200 THEN 'premium' ELSE 'standard' END AS tier FROM products;

-- 7. Order by
SELECT * FROM orders ORDER BY order_date DESC, order_id DESC LIMIT 10;

-- 8. Exclude null
SELECT * FROM customers WHERE signup_date IS NOT NULL;
