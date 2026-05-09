# Blueprint Advanced Features

> Extracted from SKILL.md — versioning, schema generation, troubleshooting.

## Versioning

### Version Naming Convention

- v1: `MyBlueprint` (no suffix)
- v2: `MyBlueprintV2`
- v3: `MyBlueprintV3`

```python
# v1 - original
class ExtractConfig(BaseModel):
    source_table: str

class Extract(Blueprint[ExtractConfig]):
    def render(self, config): ...

# v2 - breaking changes, new class
class ExtractV2Config(BaseModel):
    sources: list[dict]  # Different schema

class ExtractV2(Blueprint[ExtractV2Config]):
    def render(self, config): ...
```

### Explicit Name and Version

```python
class MyCustomExtractor(Blueprint[ExtractV3Config]):
    name = "extract"
    version = 3
    def render(self, config): ...
```

### Using Versions in YAML

```yaml
steps:
  legacy_extract:
    blueprint: extract
    version: 1
    source_table: raw.data

  new_extract:
    blueprint: extract
    sources: [{table: orders}]
```

---

## Schema Generation

```bash
blueprint schema extract > extract.schema.json
```

### Astro Project Auto-Detection

After creating or modifying a blueprint, check for `.astro/` directory. If found, auto-regenerate:

```bash
mkdir -p blueprint/generated-schemas
# For each name from `blueprint list`:
blueprint schema NAME > blueprint/generated-schemas/NAME.schema.json
```

---

## Troubleshooting

| Error | Cause | Fix |
|-------|-------|-----|
| "Blueprint not found" | Not in Python path | `blueprint list --template-dir dags/templates/` |
| "Extra inputs not permitted" | YAML typo + `extra="forbid"` | `blueprint describe <name>` for valid fields |
| DAG not appearing | Missing loader | Ensure `dags/loader.py` calls `build_all()` |
| Validation errors as import errors | v0.2.0+ surfaces Pydantic errors | Run `blueprint lint` or `blueprint describe` |
| "Cyclic dependency detected" | Circular `depends_on` | Remove dependency cycles |
| "MultipleDagArgsError" | Multiple `BlueprintDagArgs` subclasses | Keep only one per project |

### Debugging in Airflow UI

Every Blueprint task has extra Rendered Template fields:
- `blueprint_step_config` - resolved YAML config
- `blueprint_step_code` - Python source of blueprint

---

## Reference

- GitHub: https://github.com/astronomer/blueprint
- PyPI: https://pypi.org/project/airflow-blueprint/
- Astro IDE: https://docs.astronomer.io/astro/ide-blueprint
