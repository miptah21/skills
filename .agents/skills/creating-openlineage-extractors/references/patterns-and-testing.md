# OpenLineage Common Patterns & Testing

> Extracted from SKILL.md — reusable patterns, pitfalls, and testing extractors.

## Common Patterns

### Multiple Input/Output Datasets

```python
def get_openlineage_facets_on_start(self):
    inputs = [
        Dataset(namespace="postgres://prod:5432", name="public.orders"),
        Dataset(namespace="postgres://prod:5432", name="public.customers"),
    ]
    outputs = [
        Dataset(namespace="s3://warehouse", name="enriched/order_summary"),
    ]
    return OperatorLineage(inputs=inputs, outputs=outputs)
```

### Column-Level Lineage

```python
from openlineage.client.facet_v2 import (
    column_lineage_dataset,
    schema_dataset,
)

def get_openlineage_facets_on_complete(self, task_instance):
    output_facets = {
        "schema": schema_dataset.SchemaDatasetFacet(
            fields=[
                schema_dataset.SchemaDatasetFacetFields(name="order_id", type="INTEGER"),
                schema_dataset.SchemaDatasetFacetFields(name="total", type="DECIMAL"),
            ]
        ),
        "columnLineage": column_lineage_dataset.ColumnLineageDatasetFacet(
            fields={
                "order_id": column_lineage_dataset.Fields(
                    inputFields=[
                        column_lineage_dataset.InputField(
                            namespace="postgres://prod:5432",
                            name="public.orders",
                            field="id",
                        )
                    ],
                    transformationType="IDENTITY",
                ),
            }
        ),
    }
    return OperatorLineage(
        outputs=[Dataset(
            namespace="s3://warehouse",
            name="enriched/orders",
            facets=output_facets,
        )]
    )
```

### Dynamic Dataset Discovery

```python
def get_openlineage_facets_on_complete(self, task_instance):
    # Read actual tables processed from XCom or operator state
    tables = task_instance.xcom_pull(key="processed_tables") or []
    inputs = [
        Dataset(namespace="postgres://prod:5432", name=f"public.{t}")
        for t in tables
    ]
    return OperatorLineage(inputs=inputs)
```

### Error Handling in Extractors

```python
def get_openlineage_facets_on_complete(self, task_instance):
    try:
        # extraction logic
        return OperatorLineage(inputs=[...], outputs=[...])
    except Exception:
        # Never let lineage extraction break the task
        return OperatorLineage()
```

---

## Common Pitfalls

| Pitfall | Fix |
|---------|-----|
| Lineage breaks task execution | Always wrap extraction in try/except |
| Wrong method timing | `on_start` for static; `on_complete` for dynamic |
| Missing namespace | Use full URI: `postgres://host:port` |
| Extractor not found | Register in `AIRFLOW__OPENLINEAGE__EXTRACTORS` |
| Custom operator not tracked | Add OL methods or create extractor |
| Column lineage missing fields | Check `SchemaDatasetFacet` field names match |

---

## Testing Extractors

### Unit Test Pattern

```python
from unittest.mock import MagicMock
from your_module import MyOperator

def test_lineage_on_start():
    op = MyOperator(task_id="test", source="public.orders")
    result = op.get_openlineage_facets_on_start()

    assert len(result.inputs) == 1
    assert result.inputs[0].name == "public.orders"

def test_lineage_on_complete():
    op = MyOperator(task_id="test", source="public.orders")
    ti = MagicMock()
    ti.xcom_pull.return_value = {"rows": 100}

    result = op.get_openlineage_facets_on_complete(ti)
    assert len(result.outputs) == 1

def test_lineage_handles_errors():
    op = MyOperator(task_id="test", source=None)
    ti = MagicMock()
    result = op.get_openlineage_facets_on_complete(ti)
    # Should return empty, not raise
    assert result is not None
```

### Integration Test

```bash
# Enable debug logging
AIRFLOW__OPENLINEAGE__TRANSPORT='{"type": "console"}'

# Trigger DAG and check console output for lineage events
af dags trigger my_dag
af tasks logs my_dag my_task <run_id>
```

---

## Precedence Rules

When multiple lineage sources exist:

1. **Custom Extractor** (highest priority)
2. **OpenLineage methods** on operator
3. **Inlets/Outlets** annotations
4. **Built-in provider extractors** (lowest priority)
