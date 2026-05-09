# Token Optimization (RTK)

[RTK](https://github.com/rtk-ai/rtk) reduces LLM token consumption by 60-90% on shell command outputs. Single Rust binary, <10ms overhead.

## Detection

At session start, check: `rtk --version`
- **If available**: prefix eligible commands with `rtk` equivalents below
- **If unavailable**: use standard commands — zero degradation

## Command Mapping

| Standard Command | RTK Equivalent | Savings |
|-----------------|----------------|---------|
| `git status` | `rtk git status` | ~90% |
| `git diff` | `rtk git diff` | ~85% |
| `git log -n N` | `rtk git log -n N` | ~80% |
| `git add/commit/push/pull` | `rtk git add/commit/push/pull` | ~95% |
| `ls`, `tree` | `rtk ls`, `rtk tree` | ~80% |
| `cat/head/tail <file>` | `rtk read <file>` | ~70% |
| `grep/rg <pattern> <path>` | `rtk grep <pattern> <path>` | ~80% |
| `find "*.ext" .` | `rtk find "*.ext" .` | ~75% |
| `bun test` / test runners | `rtk test bun test` | ~90% |
| `bun run build` / build errors | `rtk err bun run build` | ~80% |
| `bun run lint` / ESLint/Biome | `rtk lint` | ~84% |
| `bun run typecheck` / tsc | `rtk tsc` | ~83% |
| `docker ps/images/logs` | `rtk docker ps/images/logs` | ~85% |
| `curl <url>` | `rtk curl <url>` | ~80% |

## Rules
- Never use RTK for file writes — only for reads, queries, and status commands
- If a command fails via RTK, retry without `rtk` prefix as fallback
- Use `rtk gain` periodically to report token savings to the user
- Use `rtk discover` to find missed optimization opportunities
