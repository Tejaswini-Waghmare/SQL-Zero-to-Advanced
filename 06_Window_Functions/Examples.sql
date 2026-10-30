-- Module 06: Window Functions
-- Run after setup.sql. Each example is standalone.

-- 1. Row number
SELECT order_id,customer_id,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date,order_id) AS seq FROM orders LIMIT 20;

-- 2. Rank prices
SELECT product_name,category,RANK() OVER(PARTITION BY category ORDER BY list_price DESC) AS price_rank FROM products;

-- 3. Lag
SELECT order_id,customer_id,order_date,LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date,order_id) AS prior_order_date FROM orders LIMIT 20;

-- 4. Running count
SELECT order_date,order_id,COUNT(*) OVER(ORDER BY order_date,order_id ROWS UNBOUNDED PRECEDING) AS running_count FROM orders LIMIT 20;

-- 5. NTILE
SELECT product_name,list_price,NTILE(4) OVER(ORDER BY list_price) AS quartile FROM products;

-- 6. Percent of total
SELECT category,COUNT(*) AS n,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),1) AS pct FROM products GROUP BY category;

-- 7. First order
WITH x AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date,order_id) rn FROM orders) SELECT * FROM x WHERE rn=1;

-- 8. Rolling 3 orders
SELECT order_id,customer_id,AVG(order_id) OVER(PARTITION BY customer_id ORDER BY order_date,order_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_id FROM orders LIMIT 20;
