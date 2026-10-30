-- Aggregations & GROUP BY: Reference solutions
-- These are baseline solutions; multiple valid SQL approaches exist.

-- Question 1: Group by city
SELECT city, COUNT(*) AS customers FROM customers GROUP BY city ORDER BY customers DESC;

-- Question 2: Average price
SELECT category,ROUND(AVG(list_price),2) AS avg_price FROM products GROUP BY category;

-- Question 3: HAVING
SELECT customer_id,COUNT(*) AS orders FROM orders GROUP BY customer_id HAVING COUNT(*)>=5;

-- Question 4: Conditional counts
SELECT COUNT(*) FILTER (WHERE status='completed') AS completed,COUNT(*) FILTER (WHERE status='cancelled') AS cancelled FROM orders;

-- Question 5: Revenue by region
SELECT o.region,SUM(oi.quantity*oi.unit_price) AS revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.region ORDER BY revenue DESC;

-- Question 6: Monthly orders
SELECT DATE_TRUNC('month',order_date)::date AS month,COUNT(*) FROM orders GROUP BY 1 ORDER BY 1;

-- Question 7: Min max
SELECT MIN(list_price),MAX(list_price) FROM products;

-- Question 8: Count distinct
SELECT COUNT(DISTINCT customer_id) FROM orders;

-- Stretch challenges 9-12 are open-ended: valid solutions depend on which two queries you adapt.
-- Example Q11 filter: WHERE order_date >= DATE '2025-01-01' AND order_date < DATE '2025-04-01'
-- Q10 example sanity check:
SELECT COUNT(*) AS orders_total FROM orders;
