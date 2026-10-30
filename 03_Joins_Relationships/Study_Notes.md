# Joins & Relationships

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

INNER/LEFT/FULL joins, primary/foreign keys, join grain. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. A primary key uniquely identifies rows; a foreign key links recor

A primary key uniquely identifies rows; a foreign key links records across tables.

### 2. INNER JOIN keeps matches; LEFT JOIN keeps every left-side row, wi

INNER JOIN keeps matches; LEFT JOIN keeps every left-side row, with NULLs for missing matches.

### 3. Joins can multiply rows when one order has multiple items. Define

Joins can multiply rows when one order has multiple items. Define the grain before calculating metrics.

### 4. Aggregate item-level revenue before combining with unrelated one-

Aggregate item-level revenue before combining with unrelated one-to-many tables to avoid fanout.

## Guided query walkthroughs

### Example 1: Inner join

```sql
SELECT o.order_id, c.city FROM orders o JOIN customers c ON c.customer_id=o.customer_id LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Left join

```sql
SELECT c.customer_id, COUNT(o.order_id) AS order_count FROM customers c LEFT JOIN orders o ON o.customer_id=c.customer_id GROUP BY c.customer_id ORDER BY c.customer_id;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Three tables

```sql
SELECT o.order_id,p.category,oi.quantity FROM orders o JOIN order_items oi ON o.order_id=oi.order_id JOIN products p ON p.product_id=oi.product_id LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Unmatched records

```sql
SELECT c.customer_id FROM customers c LEFT JOIN orders o ON c.customer_id=o.customer_id WHERE o.order_id IS NULL;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Revenue by customer

```sql
SELECT o.customer_id, SUM(oi.quantity*oi.unit_price) AS gross_sales FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.customer_id ORDER BY gross_sales DESC LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Join validation

```sql
SELECT COUNT(*) AS rows_after_join FROM orders o JOIN order_items oi USING(order_id);
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Distinct join keys

```sql
SELECT COUNT(DISTINCT order_id) AS orders_with_items FROM order_items;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Category sales

```sql
SELECT p.category,SUM(oi.quantity*oi.unit_price) AS revenue FROM order_items oi JOIN products p USING(product_id) JOIN orders o USING(order_id) WHERE o.status='completed' GROUP BY p.category ORDER BY revenue DESC;
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
