# Business Analytics SQL

**Database:** PostgreSQL 14+ | **Dataset:** synthetic retail commerce | **Prerequisite:** run `setup.sql` at repository root in `psql`.

## Learning objectives

Cohorts, retention, conversion, RFM and revenue. By the end, you should be able to explain the SQL pattern, run the query, and interpret the result.

## Key concepts

### 1. Define each KPI precisely

Define each KPI precisely: numerator, denominator, time window, and excluded statuses.

### 2. Revenue in this case study uses completed orders and quantity tim

Revenue in this case study uses completed orders and quantity times recorded unit price.

### 3. Cohorts group customers by first completed purchase, not signup u

Cohorts group customers by first completed purchase, not signup unless explicitly specified.

### 4. Event-derived conversion can be misleading if events are incomple

Event-derived conversion can be misleading if events are incomplete or not session-level.

## Guided query walkthroughs

### Example 1: Revenue per month

```sql
SELECT DATE_TRUNC('month',o.order_date)::date month,SUM(oi.quantity*oi.unit_price) revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY 1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 2: AOV

```sql
SELECT ROUND(AVG(order_revenue),2) AS aov FROM (SELECT o.order_id,SUM(oi.quantity*oi.unit_price) order_revenue FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY o.order_id) x;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 3: Channel share

```sql
SELECT channel,COUNT(*) n FROM orders GROUP BY channel ORDER BY n DESC;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 4: Customer lifetime revenue

```sql
SELECT o.customer_id,SUM(oi.quantity*oi.unit_price) ltv FROM orders o JOIN order_items oi USING(order_id) WHERE o.status='completed' GROUP BY 1 ORDER BY ltv DESC LIMIT 10;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 5: First purchase month

```sql
SELECT customer_id,MIN(DATE_TRUNC('month',order_date))::date AS cohort_month FROM orders WHERE status='completed' GROUP BY 1;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 6: Repeat buyers

```sql
SELECT COUNT(*) FROM (SELECT customer_id FROM orders WHERE status='completed' GROUP BY customer_id HAVING COUNT(*)>=2) t;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 7: Conversion proxy

```sql
SELECT COUNT(DISTINCT customer_id) FILTER (WHERE event_type='purchase')::numeric / NULLIF(COUNT(DISTINCT customer_id) FILTER (WHERE event_type='visit'),0) AS proxy_rate FROM events;
```

**Why this matters:** Inspect the output grain, check missing values, and explain how the query answers the stated question. Change one filter or grouping and predict how the result will change before running it.

### Example 8: RFM recency

```sql
SELECT customer_id,DATE '2026-01-01'-MAX(order_date) AS days_since_last_order,COUNT(*) AS frequency FROM orders WHERE status='completed' GROUP BY 1;
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
