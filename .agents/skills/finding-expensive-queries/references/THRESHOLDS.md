# Snowflake Query Cost & Performance Thresholds

Quantitative reference for classifying query severity. Use these as defaults when the user doesn't specify thresholds.

## Execution Time Classification
| Category | Duration | Action |
|----------|----------|--------|
| Fast | < 10 seconds | No action needed |
| Normal | 10–60 seconds | Monitor if frequent |
| Slow | 60–300 seconds | Investigate for optimization |
| Critical | > 300 seconds (5 min) | Immediate optimization priority |

## Data Scanned Classification
| Category | GB Scanned | Indicates |
|----------|-----------|-----------|
| Minimal | < 0.1 GB | Well-pruned, efficient |
| Normal | 0.1–1 GB | Acceptable for medium tables |
| Heavy | 1–10 GB | Consider partition pruning |
| Excessive | > 10 GB | Likely full table scan — optimize immediately |

## Partition Pruning Effectiveness
| Ratio (scanned/total) | Rating | Action |
|----------------------|--------|--------|
| < 5% | Excellent | No action |
| 5–25% | Good | Acceptable |
| 25–75% | Poor | Add/fix clustering key filters |
| > 75% | Critical | Nearly full scan — must fix |

## Spillage Severity
| Category | Spillage | Action |
|----------|----------|--------|
| None | 0 GB | Ideal |
| Minor | < 1 GB local | Monitor |
| Moderate | 1–5 GB local | Consider simplifying or upsizing warehouse |
| Severe | > 5 GB local or any remote | Immediate action — rewrite or upsize |

## Credit Cost Classification (per query)
| Category | Credits | Action |
|----------|---------|--------|
| Negligible | < 0.01 | Ignore |
| Normal | 0.01–0.1 | Track if recurring |
| Expensive | 0.1–1.0 | Optimize if frequent |
| Very Expensive | > 1.0 | Priority optimization target |

## Default Time Ranges
| Analysis Type | Default Period |
|--------------|---------------|
| Quick spot check | Last 24 hours |
| Weekly review | Last 7 days |
| Monthly audit | Last 30 days |
| Cost trending | Last 90 days |
