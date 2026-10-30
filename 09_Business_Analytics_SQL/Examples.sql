-- Module 09: Business Analytics SQL
-- Run after setup.sql. Each example is standalone.

-- 1. Revenue per month
SELECT DATE_TRUNC('month',o.order_date)::date month,SUM(oi.quantity*oi.unit_price) revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY 1;

-- 2. AOV
SELECT ROUND(AVG(order_revenue),2) AS aov FROM (SELECT o.order_id,SUM(oi.quantity*oi.unit_price) order_revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.order_id) x;

-- 3. Channel share
SELECT channel,COUNT(*) n FROM orders GROUP BY channel ORDER BY n DESC;

-- 4. Customer lifetime revenue
SELECT o.customer_id,SUM(oi.quantity*oi.unit_price) ltv FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY ltv DESC LIMIT 10;

-- 5. First purchase month
SELECT customer_id,MIN(DATE_TRUNC('month',order_date))::date AS cohort_month FROM orders WHERE status='completed' GROUP BY 1;

-- 6. Repeat buyers
SELECT COUNT(*) FROM (SELECT customer_id FROM orders WHERE status='completed' GROUP BY customer_id HAVING COUNT(*)>=2) t;

-- 7. Conversion proxy
SELECT COUNT(DISTINCT customer_id) FILTER (WHERE event_type='purchase')::numeric / NULLIF(COUNT(DISTINCT customer_id) FILTER (WHERE event_type='visit'),0) AS proxy_rate FROM events;

-- 8. RFM recency
SELECT customer_id,DATE '2026-01-01'-MAX(order_date) AS days_since_last_order,COUNT(*) AS frequency FROM orders WHERE status='completed' GROUP BY 1;
