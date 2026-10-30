# SQL Zero to Advanced — Study and Project Repository

A structured PostgreSQL learning repository with 11 modules, **88 runnable example queries**, **132 practice prompts** (12 per module), answer SQL, and reproducible synthetic retail data. Includes business analytics and project-style cases.

## Setup (PostgreSQL 14+)

1. Install PostgreSQL and `psql` (or use a local PostgreSQL instance).
2. Open a terminal in this repository's root directory.
3. Create a new empty database: `createdb sql_learning` (or create it using pgAdmin).
4. Run `psql -d sql_learning -f setup.sql` from the repository root. `setup.sql` uses `\copy` so paths are relative to the terminal working directory. **It drops and recreates six demo tables**; use only the new practice database.
5. Run a module: `psql -d sql_learning -f 01_SQL_Fundamentals/Examples.sql`.
6. Work through `Practice_Questions.md` before opening `Solutions.sql`.

For pgAdmin users: run the CREATE TABLE statements in Query Tool, then import each CSV with its table's Import/Export feature; `\copy` is a psql-only meta-command.

## Data dictionary

- `customers`: one row per customer, including signup date and segment.
- `products`: one row per product, including category and list price.
- `orders`: one row per order, including customer, date, status, channel, and region.
- `order_items`: one row per order line; recorded unit price and quantity.
- `events`: one row per synthetic customer event; not a complete session log.
- `messy_contacts`: intentionally inconsistent text values for cleaning practice.

**Revenue definition:** Sum of `order_items.quantity * order_items.unit_price` for orders with `status = 'completed'`. This excludes taxes, shipping, discounts, refunds, and costs. Dataset is entirely synthetic.

## Modules

01. [SQL Fundamentals](01_SQL_Fundamentals/README.md) — SELECT, DISTINCT, aliases, LIMIT, NULL and data types
02. [Filtering, Sorting & Operators](02_Filtering_Sorting_Operators/README.md) — WHERE, AND/OR, IN, BETWEEN, LIKE, ORDER BY, CASE
03. [Joins & Relationships](03_Joins_Relationships/README.md) — INNER/LEFT/FULL joins, primary/foreign keys, join grain
04. [Aggregations & GROUP BY](04_Aggregations_Group_By/README.md) — COUNT, SUM, AVG, HAVING, conditional aggregation
05. [Subqueries & CTEs](05_Subqueries_CTEs/README.md) — Scalar and correlated subqueries, EXISTS, WITH
06. [Window Functions](06_Window_Functions/README.md) — ROW_NUMBER, RANK, LAG, rolling totals
07. [Advanced SQL](07_Advanced_SQL/README.md) — Recursive CTEs, grouping sets, JSON, performance
08. [SQL Data Cleaning](08_SQL_Data_Cleaning/README.md) — TRIM, NULLIF, COALESCE, deduplication, date validation
09. [Business Analytics SQL](09_Business_Analytics_SQL/README.md) — Cohorts, retention, conversion, RFM and revenue
10. [SQL Interview Questions](10_SQL_Interview_Questions/README.md) — Top-N, gaps, duplicates, consecutive activity
11. [Real-World SQL Projects](11_Real_World_SQL_Projects/README.md) — Retail performance, customer retention and inventory

## Quality and limitations

Queries target PostgreSQL, not MySQL/SQLite. All SQL files were statically checked for structure, but no live PostgreSQL server was used to execute the complete collection. Run them locally and document any environment-specific changes. The data is illustrative and should not be represented as a real company dataset.

## Suggested GitHub presentation

Add screenshots of your actual query results and a short `Findings.md` after completing each project. Keep source code and datasets together. Credit this repository as a guided learning resource until you've independently run and reviewed the analyses.
