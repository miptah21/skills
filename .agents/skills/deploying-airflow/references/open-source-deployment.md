# Open-Source Airflow Deployment Reference

> Extracted from SKILL.md — Docker Compose and Kubernetes Helm chart deployment guides.

## Docker Compose

### Quick Start

```bash
curl -LfO 'https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml'
docker compose up -d
```

### Airflow 3 Services

| Service | Purpose |
|---------|---------|
| `airflow-apiserver` | REST API and UI (port 8080) |
| `airflow-scheduler` | Schedules DAG runs |
| `airflow-dag-processor` | Parses DAG files |
| `airflow-worker` | Executes tasks (CeleryExecutor) |
| `airflow-triggerer` | Handles deferrable tasks |
| `postgres` | Metadata database |
| `redis` | Celery message broker |

### Minimal LocalExecutor Setup

```yaml
x-airflow-common: &airflow-common
  image: apache/airflow:3
  environment: &airflow-common-env
    AIRFLOW__CORE__EXECUTOR: LocalExecutor
    AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://airflow:airflow@postgres/airflow
    AIRFLOW__CORE__LOAD_EXAMPLES: 'false'
  volumes:
    - ./dags:/opt/airflow/dags
    - ./logs:/opt/airflow/logs
    - ./plugins:/opt/airflow/plugins
  depends_on:
    postgres:
      condition: service_healthy

services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    volumes:
      - postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      interval: 10s
      retries: 5

  airflow-init:
    <<: *airflow-common
    entrypoint: /bin/bash
    command:
      - -c
      - |
        airflow db migrate
        airflow users create --username admin --firstname Admin \
          --lastname User --role Admin --email admin@example.com --password admin

  airflow-apiserver:
    <<: *airflow-common
    command: airflow api-server
    ports:
      - "8080:8080"

  airflow-scheduler:
    <<: *airflow-common
    command: airflow scheduler

  airflow-dag-processor:
    <<: *airflow-common
    command: airflow dag-processor

  airflow-triggerer:
    <<: *airflow-common
    command: airflow triggerer

volumes:
  postgres-db-volume:
```

### Common Operations

```bash
docker compose up -d              # Start
docker compose down               # Stop
docker compose logs -f airflow-scheduler  # Logs
docker compose down && docker compose up -d --build  # Rebuild
docker compose exec airflow-apiserver airflow dags list  # CLI
```

### Custom Dockerfile

```dockerfile
FROM apache/airflow:3
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
```

---

## Kubernetes (Helm Chart)

### Installation

```bash
helm repo add apache-airflow https://airflow.apache.org
helm repo update
helm install airflow apache-airflow/airflow \
  --namespace airflow --create-namespace -f values.yaml
```

### Key values.yaml

```yaml
executor: KubernetesExecutor
defaultAirflowRepository: apache/airflow
defaultAirflowTag: "3"

dags:
  gitSync:
    enabled: true
    repo: https://github.com/your-org/your-dags.git
    branch: main
    subPath: dags
    wait: 60

apiServer:
  resources:
    requests: { cpu: "250m", memory: "512Mi" }
    limits: { cpu: "500m", memory: "1Gi" }

scheduler:
  resources:
    requests: { cpu: "500m", memory: "1Gi" }
    limits: { cpu: "1000m", memory: "2Gi" }

dagProcessor:
  enabled: true
  resources:
    requests: { cpu: "250m", memory: "512Mi" }

triggerer:
  resources:
    requests: { cpu: "250m", memory: "512Mi" }

workers:
  resources:
    requests: { cpu: "500m", memory: "1Gi" }
    limits: { cpu: "2000m", memory: "4Gi" }
  replicas: 2

logs:
  persistence: { enabled: true, size: 10Gi }

postgresql:
  enabled: true
```

### DAG Deployment Strategies

1. **Git-sync** (recommended) — auto-syncs from Git
2. **Persistent Volume** — mount shared PV
3. **Baked into image** — DAGs in custom Docker image

### Useful Commands

```bash
kubectl get pods -n airflow
kubectl logs -f deployment/airflow-scheduler -n airflow
kubectl port-forward svc/airflow-apiserver 8080:8080 -n airflow
kubectl exec -it deployment/airflow-scheduler -n airflow -- airflow dags list
```

### Upgrading

```bash
helm upgrade airflow apache-airflow/airflow --namespace airflow -f values.yaml
```
