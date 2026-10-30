# Advanced SQL

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

Recursive CTEs, grouping sets, JSON, performance. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Recursive CTEs iterate until a termination condition; always set 

Recursive CTEs iterate until a termination condition; always set a safe stopping rule.

### 2. GROUPING SETS returns multiple levels of aggregation in one query

GROUPING SETS returns multiple levels of aggregation in one query.

### 3. EXPLAIN describes a query plan; EXPLAIN ANALYZE executes the quer

EXPLAIN describes a query plan; EXPLAIN ANALYZE executes the query and reports actual costs.

### 4. Indexes improve selective reads but add write overhead; validate 

Indexes improve selective reads but add write overhead; validate with realistic workloads.

## Guided query walkthroughs

### Example 1: Grouping sets

```sql
SELECT region,channel,COUNT(*) AS n FROM orders GROUP BY GROUPING SETS ((region,channel),(region),());
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Recursive sequence

```sql
WITH RECURSIVE seq(n) AS (SELECT 1 UNION ALL SELECT n+1 FROM seq WHERE n<10) SELECT * FROM seq;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: JSON construction

```sql
SELECT jsonb_build_object('customer',customer_id,'city',city) AS record FROM customers LIMIT 5;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Date arithmetic

```sql
SELECT order_id,order_date,order_date + INTERVAL '7 days' AS followup FROM orders LIMIT 5;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Filtered aggregate

```sql
SELECT region,COUNT(*) FILTER (WHERE status='returned') AS returns FROM orders GROUP BY region;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Explain plan

```sql
EXPLAIN SELECT * FROM orders WHERE customer_id=12;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Generate series

```sql
SELECT d::date FROM generate_series(DATE '2025-01-01',DATE '2025-01-07',INTERVAL '1 day') AS d;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Distinct on

```sql
SELECT DISTINCT ON (customer_id) customer_id,order_id,order_date FROM orders ORDER BY customer_id,order_date DESC,order_id DESC;
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
