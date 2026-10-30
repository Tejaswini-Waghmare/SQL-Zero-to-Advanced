# Real-World SQL Projects

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

Retail performance, customer retention and inventory. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Project narratives should state the business question, metric def

Project narratives should state the business question, metric definitions, approach, findings, and limitations.

### 2. Revenue excludes returned and cancelled orders in this synthetic 

Revenue excludes returned and cancelled orders in this synthetic case study.

### 3. An inventory demand proxy is not inventory on hand

An inventory demand proxy is not inventory on hand: no stock table is provided.

### 4. Make a defensible recommendation, but avoid causal claims from ob

Make a defensible recommendation, but avoid causal claims from observational aggregates.

## Guided query walkthroughs

### Example 1: Project 1 regional sales

```sql
SELECT o.region,p.category,ROUND(SUM(oi.quantity*oi.unit_price),2) revenue FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id) WHERE o.status='completed' GROUP BY 1,2 ORDER BY revenue DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Project 1 channel orders

```sql
SELECT channel,status,COUNT(*) FROM orders GROUP BY 1,2 ORDER BY 1,2;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Project 1 return rate

```sql
SELECT region,ROUND(100.0*COUNT(*) FILTER(WHERE status='returned')/COUNT(*),2) return_pct FROM orders GROUP BY 1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Project 2 customer cohorts

```sql
WITH firsts AS (SELECT customer_id,DATE_TRUNC('month',MIN(order_date))::date cohort FROM orders WHERE status='completed' GROUP BY 1) SELECT cohort,COUNT(*) customers FROM firsts GROUP BY 1 ORDER BY 1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Project 2 repeat purchase

```sql
SELECT COUNT(*) FILTER(WHERE n>=2) repeat_buyers,COUNT(*) total_buyers FROM (SELECT customer_id,COUNT(*) n FROM orders WHERE status='completed' GROUP BY 1) x;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Project 2 purchase frequency

```sql
SELECT customer_id,COUNT(*) completed_orders FROM orders WHERE status='completed' GROUP BY 1 ORDER BY completed_orders DESC LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Project 3 product units

```sql
SELECT p.product_name,SUM(oi.quantity) units FROM order_items oi JOIN products p USING(product_id) JOIN orders o USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY units DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Project 3 demand proxy

```sql
SELECT p.category,COUNT(DISTINCT o.order_id) orders FROM orders o JOIN order_items oi USING(order_id) JOIN products p USING(product_id) WHERE o.status='completed' GROUP BY 1 ORDER BY orders DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

## Common mistakes and debugging

- Verify table grain and primary keys before joining.
- Check for NULL values, empty result sets, and duplicate keys.
- Use explicit sort order when comparing top results.
- Validate totals against a simpler independent query.
- Keep date boundaries and order-status definitions consistent.

## Interview reflection

Explain what each query returns, which edge cases it has, and how you would validate it on production data.
