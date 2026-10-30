# SQL Fundamentals

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

SELECT, DISTINCT, aliases, LIMIT, NULL and data types. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. SQL queries are declarative

SQL queries are declarative: specify what rows and columns you want, not how to loop over them.

### 2. The logical evaluation order is FROM/JOIN, WHERE, GROUP BY, HAVIN

The logical evaluation order is FROM/JOIN, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT.

### 3. NULL means unknown or missing. Use IS NULL rather than = NULL.

NULL means unknown or missing. Use IS NULL rather than = NULL.

### 4. SELECT * is convenient for exploration but explicit columns are b

SELECT * is convenient for exploration but explicit columns are better for stable reporting.

## Guided query walkthroughs

### Example 1: Select columns

```sql
SELECT customer_id, city FROM customers LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: All columns

```sql
SELECT * FROM products LIMIT 5;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Distinct values

```sql
SELECT DISTINCT city FROM customers ORDER BY city;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Aliases

```sql
SELECT product_name AS item, list_price AS price_usd FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Arithmetic

```sql
SELECT product_name, list_price * 1.08 AS price_with_tax FROM products;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Null check

```sql
SELECT * FROM customers WHERE city IS NULL;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Sorting

```sql
SELECT * FROM products ORDER BY list_price DESC LIMIT 3;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Count rows

```sql
SELECT COUNT(*) AS total_customers FROM customers;
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
