-- Module 08: SQL Data Cleaning
-- Run after setup.sql. Each example is standalone.

-- 1. Trim and lowercase
SELECT contact_id,LOWER(TRIM(raw_email)) AS email FROM messy_contacts;

-- 2. Blank to null
SELECT contact_id,NULLIF(TRIM(raw_city),'') AS city FROM messy_contacts;

-- 3. Validate email pattern
SELECT * FROM messy_contacts WHERE TRIM(raw_email) NOT LIKE '%@%.%';

-- 4. Duplicate groups
SELECT LOWER(TRIM(raw_email)) AS email,COUNT(*) FROM messy_contacts WHERE NULLIF(TRIM(raw_email),'') IS NOT NULL GROUP BY 1 HAVING COUNT(*)>1;

-- 5. Dedup preview
WITH x AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY LOWER(TRIM(raw_email)) ORDER BY contact_id) rn FROM messy_contacts) SELECT * FROM x WHERE rn=1;

-- 6. Clean city
SELECT INITCAP(TRIM(raw_city)) AS city FROM messy_contacts;

-- 7. Quality counts
SELECT COUNT(*) AS total,COUNT(*) FILTER(WHERE NULLIF(TRIM(raw_email),'') IS NULL) AS missing_email FROM messy_contacts;

-- 8. Safe clean view
CREATE OR REPLACE VIEW clean_contacts AS SELECT contact_id,LOWER(NULLIF(TRIM(raw_email),'')) AS email,INITCAP(NULLIF(TRIM(raw_city),'')) AS city FROM messy_contacts;
