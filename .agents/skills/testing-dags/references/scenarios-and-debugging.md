# DAG Testing Scenarios & Debugging Tips

> Extracted from SKILL.md — scenario-specific testing patterns and debugging reference.

## Testing Scenarios

### Scenario 1: First-Time DAG Deployment

```bash
# 1. Parse check
astro dev parse

# 2. Trigger with no data dependencies
af dags trigger my_new_dag

# 3. Watch execution
af tasks logs my_new_dag <task_id> <run_id>
```

### Scenario 2: DAG After Code Change

```bash
# 1. Restart to pick up code changes
astro dev restart

# 2. Verify parsing
astro dev parse

# 3. Trigger and monitor
af dags trigger my_dag
af dags list-runs my_dag --limit 1
```

### Scenario 3: Incremental/Partitioned DAG

```bash
# Test with specific execution date
af dags trigger my_dag --conf '{"logical_date": "2024-01-15T00:00:00+00:00"}'
```

### Scenario 4: DAG with External Dependencies

```bash
# 1. Verify connections
af connections list | grep my_conn

# 2. Test connection
af connections test my_conn

# 3. Trigger
af dags trigger my_dag
```

### Scenario 5: Backfill Testing

```bash
af dags backfill my_dag --start-date 2024-01-01 --end-date 2024-01-07
```

---

## Debugging Tips

### Common Failures

| Symptom | Likely Cause | Fix |
|---------|-------------|-----|
| DAG not appearing | Parse error | `astro dev parse`, check logs |
| Task stuck in queued | No available worker/slot | Check executor config |
| Task fails immediately | Import error in DAG | Check `astro dev logs --scheduler` |
| Task timeout | Long-running query | Increase timeout or optimize |
| "Connection not found" | Missing Airflow connection | `af connections add ...` |
| XCom too large | Pushing large data | Use external storage |

### Log Analysis Pattern

```bash
# Get the latest failed run
af dags list-runs my_dag --state failed --limit 1

# Get failed task instances
af tasks list my_dag <run_id> --state failed

# Read the full log
af tasks logs my_dag <task_id> <run_id> --full
```

### Quick Health Check

```bash
# Are all services running?
astro dev status

# Any import errors?
astro dev parse

# Recent failures?
af dags list-runs my_dag --state failed --limit 5
```
