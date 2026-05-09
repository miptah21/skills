# Cosmos Appendices: Airflow 3 Compatibility & Operational Extras

> Extracted from SKILL.md — Airflow 3 migration notes, caching, memory optimization, artifact upload, dbt docs hosting.

## Airflow 3 Compatibility

### Import Differences

| Airflow 3.x | Airflow 2.x |
|-------------|-------------|
| `from airflow.sdk import dag, task` | `from airflow.decorators import dag, task` |
| `from airflow.sdk import chain` | `from airflow.models.baseoperator import chain` |

### Asset/Dataset URI Format Change

Cosmos ≤1.9 (Airflow 2 Datasets):
```
postgres://0.0.0.0:5434/postgres.public.orders
```

Cosmos ≥1.10 (Airflow 3 Assets):
```
postgres://0.0.0.0:5434/postgres/public/orders
```

> **CRITICAL**: Update asset URIs when upgrading to Airflow 3.

---

## Operational Extras

### Caching

Cosmos caches artifacts to speed up parsing. Enabled by default.
Reference: https://astronomer.github.io/astronomer-cosmos/configuration/caching.html

### Memory-Optimized Imports

```bash
AIRFLOW__COSMOS__ENABLE_MEMORY_OPTIMISED_IMPORTS=True
```

When enabled:
```python
from cosmos.airflow.dag import DbtDag  # instead of: from cosmos import DbtDag
```

### Artifact Upload to Object Storage

```bash
AIRFLOW__COSMOS__REMOTE_TARGET_PATH=s3://bucket/target_dir/
AIRFLOW__COSMOS__REMOTE_TARGET_PATH_CONN_ID=aws_default
```

```python
from cosmos.io import upload_to_cloud_storage

my_dag = DbtDag(
    # ...
    operator_args={"callback": upload_to_cloud_storage},
)
```

### dbt Docs Hosting (Airflow 3.1+ / Cosmos 1.11+)

```bash
AIRFLOW__COSMOS__DBT_DOCS_PROJECTS='{
    "my_project": {
        "dir": "s3://bucket/docs/",
        "index": "index.html",
        "conn_id": "aws_default",
        "name": "My Project"
    }
}'
```

Reference: https://astronomer.github.io/astronomer-cosmos/configuration/hosting-docs.html
