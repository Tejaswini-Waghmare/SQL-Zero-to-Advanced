# SQL Interview Questions

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

Top-N, gaps, duplicates, consecutive activity. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Interview questions test grain, joins, window functions, edge cas

Interview questions test grain, joins, window functions, edge cases, and communication.

### 2. Ask how ties should be treated before answering Top-N questions.

Ask how ties should be treated before answering Top-N questions.

### 3. Always clarify whether duplicate rows are expected or erroneous.

Always clarify whether duplicate rows are expected or erroneous.

### 4. Explain complexity, NULL behavior, and why a query is correct.

Explain complexity, NULL behavior, and why a query is correct.

## Guided query walkthroughs

### Example 1: Second most expensive

```sql
SELECT * FROM (SELECT *,DENSE_RANK() OVER(ORDER BY list_price DESC) r FROM products) x WHERE r=2;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Latest per customer

```sql
SELECT DISTINCT ON(customer_id) customer_id,order_id,order_date FROM orders ORDER BY customer_id,order_date DESC,order_id DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Duplicate check

```sql
SELECT customer_id,order_date,COUNT(*) n FROM orders GROUP BY 1,2 HAVING COUNT(*)>1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Top 2 per category

```sql
SELECT * FROM (SELECT *,ROW_NUMBER() OVER(PARTITION BY category ORDER BY list_price DESC,product_id) r FROM products) x WHERE r<=2;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Gaps between orders

```sql
SELECT customer_id,order_date-LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date,order_id) AS days_gap FROM orders LIMIT 30;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Customers without orders

```sql
SELECT c.customer_id FROM customers c WHERE NOT EXISTS(SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Running total

```sql
WITH daily AS (SELECT order_date,COUNT(*) n FROM orders GROUP BY 1) SELECT order_date,n,SUM(n) OVER(ORDER BY order_date) running_n FROM daily ORDER BY order_date;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Median price

```sql
SELECT PERCENTILE_CONT(.5) WITHIN GROUP(ORDER BY list_price) FROM products;
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
