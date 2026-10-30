# Subqueries & CTEs

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

Scalar and correlated subqueries, EXISTS, WITH. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. A subquery returns a scalar, set, or relation; choose based on th

A subquery returns a scalar, set, or relation; choose based on the intended comparison.

### 2. EXISTS checks whether a matching row exists and avoids duplicate-

EXISTS checks whether a matching row exists and avoids duplicate-induced issues.

### 3. A CTE names intermediate results, improving readability; it is no

A CTE names intermediate results, improving readability; it is not automatically faster.

### 4. Correlated subqueries reference an outer query and may be more ex

Correlated subqueries reference an outer query and may be more expensive than a join.

## Guided query walkthroughs

### Example 1: CTE basics

```sql
WITH expensive AS (SELECT * FROM products WHERE list_price>150) SELECT COUNT(*) FROM expensive;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Subquery IN

```sql
SELECT * FROM customers WHERE customer_id IN (SELECT customer_id FROM orders WHERE status='completed');
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: EXISTS

```sql
SELECT c.customer_id FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Correlated subquery

```sql
SELECT p.* FROM products p WHERE p.list_price > (SELECT AVG(p2.list_price) FROM products p2 WHERE p2.category=p.category);
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Two CTEs

```sql
WITH a AS (SELECT customer_id,COUNT(*) n FROM orders GROUP BY 1), b AS (SELECT AVG(n) avg_n FROM a) SELECT * FROM b;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Scalar subquery

```sql
SELECT product_name,list_price,(SELECT AVG(list_price) FROM products) AS overall_avg FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: NOT EXISTS

```sql
SELECT c.customer_id FROM customers c WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.customer_id=c.customer_id);
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: CTE revenue

```sql
WITH totals AS (SELECT order_id,SUM(quantity*unit_price) revenue FROM order_items GROUP BY order_id) SELECT AVG(revenue) FROM totals;
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
