-- Advanced SQL: Reference solutions
-- These are baseline solutions; multiple valid SQL approaches exist.

-- Question 1: Grouping sets
SELECT region,channel,COUNT(*) AS n FROM orders GROUP BY GROUPING SETS ((region,channel),(region),());

-- Question 2: Recursive sequence
WITH RECURSIVE seq(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM seq WHERE n<10) SELECT * FROM seq;

-- Question 3: JSON construction
SELECT jsonb_build_object('customer',customer_id,'city',city) AS record FROM customers LIMIT 5;

-- Question 4: Date arithmetic
SELECT order_id,order_date,order_date + INTERVAL '7 days' AS followup FROM orders LIMIT 5;

-- Question 5: Filtered aggregate
SELECT region,COUNT(*) FILTER (WHERE status='returned') AS returns FROM orders GROUP BY region;

-- Question 6: Explain plan
EXPLAIN SELECT * FROM orders WHERE customer_id=12;

-- Question 7: Generate series
SELECT d::date FROM generate_series(DATE '2025-01-01',DATE '2025-01-07',INTERVAL '1 day') AS d;

-- Question 8: Distinct on
SELECT DISTINCT ON (customer_id) customer_id,order_id,order_date FROM orders ORDER BY customer_id,order_date DESC,order_id DESC;

-- Stretch challenges 9-12 are open-ended: valid solutions depend on which two queries you adapt.
-- Example Q11 filter: WHERE order_date >= DATE '2025-01-01' AND order_date < DATE '2025-04-01'
-- Q10 example sanity check:
SELECT COUNT(*) AS orders_total FROM orders;
