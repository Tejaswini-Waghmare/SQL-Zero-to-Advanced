# SQL Data Cleaning

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

TRIM, NULLIF, COALESCE, deduplication, date validation. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Data cleaning should be reproducible and non-destructive; start w

Data cleaning should be reproducible and non-destructive; start with a SELECT or view.

### 2. TRIM removes surrounding whitespace; NULLIF turns blank strings i

TRIM removes surrounding whitespace; NULLIF turns blank strings into NULL.

### 3. Normalize case carefully

Normalize case carefully: not all identifiers are case-insensitive.

### 4. For deduplication, define a business key and deterministic tie-br

For deduplication, define a business key and deterministic tie-breaker before removing anything.

## Guided query walkthroughs

### Example 1: Trim and lowercase

```sql
SELECT contact_id,LOWER(TRIM(raw_email)) AS email FROM messy_contacts;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: Blank to null

```sql
SELECT contact_id,NULLIF(TRIM(raw_city),'') AS city FROM messy_contacts;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Validate email pattern

```sql
SELECT * FROM messy_contacts WHERE TRIM(raw_email) NOT LIKE '%@%.%';
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Duplicate groups

```sql
SELECT LOWER(TRIM(raw_email)) AS email,COUNT(*) FROM messy_contacts WHERE NULLIF(TRIM(raw_email),'') IS NOT NULL GROUP BY 1 HAVING COUNT(*)>1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: Dedup preview

```sql
WITH x AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY LOWER(TRIM(raw_email)) ORDER BY contact_id) rn FROM messy_contacts) SELECT * FROM x WHERE rn=1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Clean city

```sql
SELECT INITCAP(TRIM(raw_city)) AS city FROM messy_contacts;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Quality counts

```sql
SELECT COUNT(*) AS total,COUNT(*) FILTER(WHERE NULLIF(TRIM(raw_email),'') IS NULL) AS missing_email FROM messy_contacts;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: Safe clean view

```sql
CREATE OR REPLACE VIEW clean_contacts AS SELECT contact_id,LOWER(NULLIF(TRIM(raw_email),'')) AS email,INITCAP(NULLIF(TRIM(raw_city),'')) AS city FROM messy_contacts;
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
