-- Filtering, Sorting & Operators: Reference solutions
-- These are baseline solutions; multiple valid SQL approaches exist.

-- Question 1: Numeric filter
SELECT * FROM products WHERE list_price >= 100;

-- Question 2: IN list
SELECT * FROM customers WHERE city IN ('Atlanta','Austin');

-- Question 3: BETWEEN
SELECT * FROM products WHERE list_price BETWEEN 50 AND 200;

-- Question 4: LIKE
SELECT * FROM products WHERE product_name ILIKE '%a%';

-- Question 5: Boolean grouping
SELECT * FROM orders WHERE status = 'completed' AND (channel = 'web' OR channel = 'mobile');

-- Question 6: CASE labels
SELECT product_name, CASE WHEN list_price >= 200 THEN 'premium' ELSE 'standard' END AS tier FROM products;

-- Question 7: Order by
SELECT * FROM orders ORDER BY order_date DESC, order_id DESC LIMIT 10;

-- Question 8: Exclude null
SELECT * FROM customers WHERE signup_date IS NOT NULL;

-- Stretch challenges 9-12 are open-ended: valid solutions depend on which two queries you adapt.
-- Example Q11 filter: WHERE order_date >= DATE '2025-01-01' AND order_date < DATE '2025-04-01'
-- Q10 example sanity check:
SELECT COUNT(*) AS orders_total FROM orders;
