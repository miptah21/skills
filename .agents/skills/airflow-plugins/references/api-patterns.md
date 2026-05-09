# Airflow Plugin API Patterns

> Extracted from SKILL.md — loaded when implementing specific API endpoint patterns.

## JWT Token Management

Cache one token per process. Refresh 5 minutes before the 1-hour expiry:

> Replace `MYPLUGIN_` with a short uppercase prefix derived from the plugin name.

```python
import asyncio, os, threading, time
import airflow_client.client as airflow_sdk
import requests

AIRFLOW_HOST  = os.environ.get("MYPLUGIN_HOST",     "http://localhost:8080")
AIRFLOW_USER  = os.environ.get("MYPLUGIN_USERNAME", "admin")
AIRFLOW_PASS  = os.environ.get("MYPLUGIN_PASSWORD", "admin")
AIRFLOW_TOKEN = os.environ.get("MYPLUGIN_TOKEN")    # Astronomer Astro: Deployment API token

_cached_token: str | None = None
_token_expires_at: float  = 0.0
_token_lock = threading.Lock()

def _fetch_fresh_token() -> str:
    response = requests.post(
        f"{AIRFLOW_HOST}/auth/token",
        json={"username": AIRFLOW_USER, "password": AIRFLOW_PASS},
        timeout=10,
    )
    response.raise_for_status()
    return response.json()["access_token"]

def _get_token() -> str:
    if AIRFLOW_TOKEN:
        return AIRFLOW_TOKEN
    global _cached_token, _token_expires_at
    now = time.monotonic()
    if _cached_token and now < _token_expires_at:
        return _cached_token
    with _token_lock:
        if _cached_token and now < _token_expires_at:
            return _cached_token
        _cached_token = _fetch_fresh_token()
        _token_expires_at = now + 55 * 60
    return _cached_token

def _make_config() -> airflow_sdk.Configuration:
    config = airflow_sdk.Configuration(host=AIRFLOW_HOST)
    config.access_token = _get_token()
    return config
```

## Common API Endpoints

### List DAGs
```python
@app.get("/api/dags")
async def list_dags():
    def _fetch():
        with airflow_sdk.ApiClient(_make_config()) as client:
            return DAGApi(client).get_dags(limit=100).dags
    dags = await asyncio.to_thread(_fetch)
    return [{"dag_id": d.dag_id, "is_paused": d.is_paused} for d in dags]
```

### Trigger DAG
```python
@app.post("/api/dags/{dag_id}/trigger")
async def trigger_dag(dag_id: str):
    def _run():
        with airflow_sdk.ApiClient(_make_config()) as client:
            return DagRunApi(client).trigger_dag_run(dag_id, TriggerDAGRunPostBody())
    result = await asyncio.to_thread(_run)
    return {"run_id": result.dag_run_id, "state": normalize_state(result.state)}
```

### Latest Run, Task Instances, Task Log
```python
# Latest run
runs = DagRunApi(client).get_dag_runs(dag_id, limit=1, order_by="-start_date").dag_runs

# Task instances
tasks = TaskInstanceApi(client).get_task_instances(dag_id, run_id).task_instances

# Task log
log = TaskInstanceApi(client).get_log(dag_id, run_id, task_id, try_number, map_index=-1)
```

### Streaming Proxy
```python
from starlette.responses import StreamingResponse

@app.get("/api/files/{filename}")
async def proxy_file(filename: str):
    def _stream():
        return requests.get(f"https://files.example.com/{filename}", stream=True)
    response = await asyncio.to_thread(_stream)
    return StreamingResponse(response.iter_content(chunk_size=8192),
        media_type="application/octet-stream")
```

## Other Component Types

### Macros
```python
def format_confidence(confidence: float) -> str:
    return f"{confidence * 100:.2f}%"

class MyPlugin(AirflowPlugin):
    name = "my_plugin"
    macros = [format_confidence]
```
Usage: `{{ macros.my_plugin.format_confidence(0.95) }}`

### Middleware
```python
class AuditMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request, call_next):
        response = await call_next(request)
        return response

class MyPlugin(AirflowPlugin):
    fastapi_root_middlewares = [
        {"middleware": AuditMiddleware, "args": [], "kwargs": {}, "name": "Audit"}
    ]
```

### Operator Extra Links
```python
from airflow.sdk.bases.operatorlink import BaseOperatorLink

class MyDashboardLink(BaseOperatorLink):
    name = "Open in Dashboard"
    def get_link(self, operator, *, ti_key, **context):
        return f"https://dashboard.example.com/tasks/{ti_key.task_id}"
```

### React Apps
```python
react_apps = [{"name": "My Plugin", "bundle_url": "/my-plugin/my-app.js",
    "destination": "nav", "category": "browse", "url_route": "my-plugin"}]
```
Bundle must expose: `globalThis['My Plugin'] = MyComponent;`

## Environment Variables & Deployment

**Local:** `.env` with `MYPLUGIN_HOST`, `MYPLUGIN_USERNAME`, `MYPLUGIN_PASSWORD`

**Astronomer Production:**
```bash
astro deployment variable create MYPLUGIN_TOKEN=<token>
```

**Debug commands:**
```bash
astro dev logs --api-server    # FastAPI import errors
astro dev logs --scheduler     # macros, timetables, listeners
astro dev restart              # required after Python changes
```
