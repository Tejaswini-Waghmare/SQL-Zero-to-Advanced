# Filtering, Sorting & Operators

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

WHERE, AND/OR, IN, BETWEEN, LIKE, ORDER BY, CASE. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. WHERE filters individual rows before aggregation.

WHERE filters individual rows before aggregation.

### 2. AND takes precedence over OR

AND takes precedence over OR: use parentheses to make business rules explicit.

### 3. BETWEEN is inclusive at both endpoints; timestamp boundaries need

BETWEEN is inclusive at both endpoints; timestamp boundaries need care.

### 4. LIKE uses % for any-length wildcard and _ for one character; ILIK

LIKE uses % for any-length wildcard and _ for one character; ILIKE ignores case in PostgreSQL.

## Guided query walkthroughs

### Example 1: Numeric filter

```sql
SELECT * FROM products WHERE list_price >= 100;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: IN list

```sql
SELECT * FROM customers WHERE city IN ('Atlanta','Austin');
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: BETWEEN

```sql
SELECT * FROM products WHERE list_price BETWEEN 50 AND 200;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: LIKE

```sql
SELECT * FROM products WHERE product_name ILIKE '%a%';
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Boolean grouping

```sql
SELECT * FROM orders WHERE status = 'completed' AND (channel = 'web' OR channel = 'mobile');
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: CASE labels

```sql
SELECT product_name, CASE WHEN list_price >= 200 THEN 'premium' ELSE 'standard' END AS tier FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Order by

```sql
SELECT * FROM orders ORDER BY order_date DESC, order_id DESC LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Exclude null

```sql
SELECT * FROM customers WHERE signup_date IS NOT NULL;
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
