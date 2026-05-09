# Incremental Strategy Examples

Detailed SQL examples for each incremental strategy. Referenced from the main SKILL.md.

## Append (Simplest)
```sql
{{ config(materialized='incremental', incremental_strategy='append') }}

select * from {{ source('events', 'raw') }}
{% if is_incremental() %}
where event_timestamp > (select max(event_timestamp) from {{ this }})
{% endif %}
```

- No unique_key needed
- Fastest performance
- **Only use for append-only data** (logs, events, immutable records)

## Merge (Default)
```sql
{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='id'
) }}

select * from {{ source('crm', 'contacts') }}
{% if is_incremental() %}
where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
```

- Requires unique_key
- Handles updates and inserts
- Most common strategy

## Delete+Insert (Batch Updates)
```sql
{{ config(
    materialized='incremental',
    incremental_strategy='delete+insert',
    unique_key='id'
) }}

select * from {{ source('orders', 'raw') }}
{% if is_incremental() %}
where order_date >= {{ dbt.dateadd('day', -7, dbt.current_timestamp()) }}
{% endif %}
```

- Deletes all matching rows first
- Good for reprocessing batches
- Use when merge has duplicate key issues

## Insert Overwrite (Partitioned)
```sql
{{ config(
    materialized='incremental',
    incremental_strategy='insert_overwrite',
    partition_by={'field': 'event_date', 'data_type': 'date'}
) }}

select * from {{ source('events', 'raw') }}
{% if is_incremental() %}
where event_date >= {{ dbt.dateadd('day', -3, dbt.current_timestamp()) }}
{% endif %}
```

- Replaces entire partitions
- Best for partitioned tables in BigQuery/Spark
- No unique_key needed (operates on partitions)

## Troubleshooting Patterns

### Merge Fails with Duplicate Key — Deduplication Fix
```sql
with deduplicated as (
    select *,
        row_number() over (partition by id order by updated_at desc) as rn
    from {{ source('schema', 'table') }}
    {% if is_incremental() %}
    where updated_at > (select max(updated_at) from {{ this }})
    {% endif %}
)
select * from deduplicated where rn = 1
```

### No Partition Pruning — Static Date Fix
```sql
{% if is_incremental() %}
where updated_at >= {{ dbt.dateadd('day', -3, dbt.current_timestamp()) }}
  and updated_at > (select max(updated_at) from {{ this }})
{% endif %}
```

### Late-Arriving Data — Lookback Window Fix
```sql
{% set lookback_days = 3 %}

{% if is_incremental() %}
where updated_at >= {{ dbt.dateadd('day', -lookback_days, dbt.current_timestamp()) }}
{% endif %}
```
