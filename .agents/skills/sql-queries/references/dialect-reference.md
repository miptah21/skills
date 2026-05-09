# SQL Dialect Reference

> Extracted from SKILL.md — dialect-specific syntax for PostgreSQL, Snowflake, BigQuery, Redshift, Databricks.

## PostgreSQL (including Aurora, RDS, Supabase, Neon)

**Date/time:**
```sql
CURRENT_DATE, CURRENT_TIMESTAMP, NOW()
date_column + INTERVAL '7 days'
DATE_TRUNC('month', created_at)
EXTRACT(YEAR FROM created_at)
TO_CHAR(created_at, 'YYYY-MM-DD')
```

**Strings:** `||`, `ILIKE`, `~` (regex), `SPLIT_PART`, `REGEXP_REPLACE`

**JSON/Arrays:** `->>'key'`, `#>>'{path}'`, `ARRAY_AGG()`, `@>`

**Tips:** `EXPLAIN ANALYZE`, indexes, `EXISTS` over `IN`, partial indexes, connection pooling

---

## Snowflake

**Date/time:**
```sql
CURRENT_DATE(), SYSDATE()
DATEADD(day, 7, date_column)
DATEDIFF(day, start_date, end_date)
DATE_TRUNC('month', created_at)
YEAR(created_at), MONTH(created_at)
```

**Semi-structured:** `data:customer:name::STRING`, `LATERAL FLATTEN()`

**Tips:** Clustering keys (not indexes), partition pruning, `RESULT_SCAN()`, transient tables

---

## BigQuery

**Date/time:**
```sql
CURRENT_DATE(), CURRENT_TIMESTAMP()
DATE_ADD(date_column, INTERVAL 7 DAY)
DATE_DIFF(end_date, start_date, DAY)
DATE_TRUNC(created_at, MONTH)
FORMAT_DATE('%Y-%m-%d', date_column)
```

**Strings:** No ILIKE → use `LOWER()`, `REGEXP_CONTAINS()`, `REGEXP_EXTRACT()`

**Arrays/Structs:** `UNNEST()`, `ARRAY_LENGTH()`, `struct_column.field_name`

**Tips:** Filter on partition columns, `APPROX_COUNT_DISTINCT()`, avoid `SELECT *`, dry run

---

## Redshift

**Date/time:**
```sql
CURRENT_DATE, GETDATE(), SYSDATE
DATEADD(day, 7, date_column)
DATEDIFF(day, start_date, end_date)
DATE_TRUNC('month', created_at)
```

**Strings:** `ILIKE`, `REGEXP_INSTR()`, `LISTAGG()`

**Tips:** DISTKEY for collocated joins, SORTKEY for filters, watch DS_BCAST/DS_DIST, `VACUUM`

---

## Databricks SQL

**Date/time:**
```sql
CURRENT_DATE(), CURRENT_TIMESTAMP()
DATE_ADD(date_column, 7)
DATEDIFF(end_date, start_date)
DATE_TRUNC('MONTH', created_at)
```

**Delta Lake:**
```sql
SELECT * FROM my_table TIMESTAMP AS OF '2024-01-15'
SELECT * FROM my_table VERSION AS OF 42
DESCRIBE HISTORY my_table
MERGE INTO target USING source ON target.id = source.id
  WHEN MATCHED THEN UPDATE SET *
  WHEN NOT MATCHED THEN INSERT *
```

**Tips:** `OPTIMIZE` + `ZORDER`, Photon engine, `CACHE TABLE`, partition by low-cardinality dates
