-- Module 01: SQL Fundamentals
-- Run after setup.sql. Each example is standalone.

-- 1. Select columns
SELECT customer_id, city FROM customers LIMIT 10;

-- 2. All columns
SELECT * FROM products LIMIT 5;

-- 3. Distinct values
SELECT DISTINCT city FROM customers ORDER BY city;

-- 4. Aliases
SELECT product_name AS item, list_price AS price_usd FROM products;

-- 5. Arithmetic
SELECT product_name, list_price * 1.08 AS price_with_tax FROM products;

-- 6. Null check
SELECT * FROM customers WHERE city IS NULL;

-- 7. Sorting
SELECT * FROM products ORDER BY list_price DESC LIMIT 3;

-- 8. Count rows
SELECT COUNT(*) AS total_customers FROM customers;
