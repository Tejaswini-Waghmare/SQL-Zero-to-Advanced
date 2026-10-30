-- SQL Fundamentals: Reference solutions
-- These are baseline solutions; multiple valid SQL approaches exist.

-- Question 1: Select columns
SELECT customer_id, city FROM customers LIMIT 10;

-- Question 2: All columns
SELECT * FROM products LIMIT 5;

-- Question 3: Distinct values
SELECT DISTINCT city FROM customers ORDER BY city;

-- Question 4: Aliases
SELECT product_name AS item, list_price AS price_usd FROM products;

-- Question 5: Arithmetic
SELECT product_name, list_price * 1.08 AS price_with_tax FROM products;

-- Question 6: Null check
SELECT * FROM customers WHERE city IS NULL;

-- Question 7: Sorting
SELECT * FROM products ORDER BY list_price DESC LIMIT 3;

-- Question 8: Count rows
SELECT COUNT(*) AS total_customers FROM customers;

-- Stretch challenges 9-12 are open-ended: valid solutions depend on which two queries you adapt.
-- Example Q11 filter: WHERE order_date >= DATE '2025-01-01' AND order_date < DATE '2025-04-01'
-- Q10 example sanity check:
SELECT COUNT(*) AS orders_total FROM orders;
