# Aggregations & GROUP BY

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

COUNT, SUM, AVG, HAVING, conditional aggregation. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. GROUP BY defines the grain of each output row.

GROUP BY defines the grain of each output row.

### 2. WHERE filters before groups; HAVING filters after groups are calc

WHERE filters before groups; HAVING filters after groups are calculated.

### 3. COUNT(*) counts rows, COUNT(column) excludes NULL values.

COUNT(*) counts rows, COUNT(column) excludes NULL values.

### 4. Conditional aggregates using FILTER are clear PostgreSQL syntax.

Conditional aggregates using FILTER are clear PostgreSQL syntax.

## Guided query walkthroughs

### Example 1: Group by city

```sql
SELECT city, COUNT(*) AS customers FROM customers GROUP BY city ORDER BY customers DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Average price

```sql
SELECT category,ROUND(AVG(list_price),2) AS avg_price FROM products GROUP BY category;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: HAVING

```sql
SELECT customer_id,COUNT(*) AS orders FROM orders GROUP BY customer_id HAVING COUNT(*)>=5;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Conditional counts

```sql
SELECT COUNT(*) FILTER (WHERE status='completed') AS completed,COUNT(*) FILTER (WHERE status='cancelled') AS cancelled FROM orders;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Revenue by region

```sql
SELECT o.region,SUM(oi.quantity*oi.unit_price) AS revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.region ORDER BY revenue DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Monthly orders

```sql
SELECT DATE_TRUNC('month',order_date)::date AS month,COUNT(*) FROM orders GROUP BY 1 ORDER BY 1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Min max

```sql
SELECT MIN(list_price),MAX(list_price) FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Count distinct

```sql
SELECT COUNT(DISTINCT customer_id) FROM orders;
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
