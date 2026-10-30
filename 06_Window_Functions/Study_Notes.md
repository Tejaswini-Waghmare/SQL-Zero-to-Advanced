# Window Functions

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

ROW_NUMBER, RANK, LAG, rolling totals. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Window functions preserve individual rows while computing metrics

Window functions preserve individual rows while computing metrics over partitions.

### 2. PARTITION BY defines independent groups and ORDER BY establishes 

PARTITION BY defines independent groups and ORDER BY establishes sequence.

### 3. ROW_NUMBER always gives unique positions; RANK and DENSE_RANK han

ROW_NUMBER always gives unique positions; RANK and DENSE_RANK handle ties differently.

### 4. Specify ROWS frames for predictable running and rolling calculati

Specify ROWS frames for predictable running and rolling calculations.

## Guided query walkthroughs

### Example 1: Row number

```sql
SELECT order_id,customer_id,ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date,order_id) AS seq FROM orders LIMIT 20;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Rank prices

```sql
SELECT product_name,category,RANK() OVER(PARTITION BY category ORDER BY list_price DESC) AS price_rank FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Lag

```sql
SELECT order_id,customer_id,order_date,LAG(order_date) OVER(PARTITION BY customer_id ORDER BY order_date,order_id) AS prior_order_date FROM orders LIMIT 20;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Running count

```sql
SELECT order_date,order_id,COUNT(*) OVER(ORDER BY order_date,order_id ROWS UNBOUNDED PRECEDING) AS running_count FROM orders LIMIT 20;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: NTILE

```sql
SELECT product_name,list_price,NTILE(4) OVER(ORDER BY list_price) AS quartile FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Percent of total

```sql
SELECT category,COUNT(*) AS n,ROUND(100.0*COUNT(*)/SUM(COUNT(*)) OVER(),1) AS pct FROM products GROUP BY category;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: First order

```sql
WITH x AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date,order_id) rn FROM orders) SELECT * FROM x WHERE rn=1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Rolling 3 orders

```sql
SELECT order_id,customer_id,AVG(order_id) OVER(PARTITION BY customer_id ORDER BY order_date,order_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_id FROM orders LIMIT 20;
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
