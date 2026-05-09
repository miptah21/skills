# Registry Operations Reference

## Schema

```json
{
  "worktrees": [
    {
      "id": "unique-uuid",
      "project": "obsidian-ai-agent",
      "repoPath": "/Users/rasmus/Projects/obsidian-ai-agent",
      "branch": "feature/auth",
      "branchSlug": "feature-auth",
      "worktreePath": "/Users/rasmus/tmp/worktrees/obsidian-ai-agent/feature-auth",
      "ports": [8100, 8101],
      "createdAt": "2025-12-04T10:00:00Z",
      "validatedAt": "2025-12-04T10:02:00Z",
      "agentLaunchedAt": "2025-12-04T10:03:00Z",
      "task": "Implement OAuth login",
      "prNumber": null,
      "status": "active"
    }
  ],
  "portPool": {
    "start": 8100,
    "end": 8199,
    "allocated": [8100, 8101]
  }
}
```

## Field Descriptions

**Worktree entry fields:**
| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique identifier (UUID) |
| `project` | string | Project name (from git remote or directory) |
| `repoPath` | string | Absolute path to original repository |
| `branch` | string | Full branch name (e.g., `feature/auth`) |
| `branchSlug` | string | Filesystem-safe name (e.g., `feature-auth`) |
| `worktreePath` | string | Absolute path to worktree |
| `ports` | number[] | Allocated port numbers (usually 2) |
| `createdAt` | string | ISO 8601 timestamp |
| `validatedAt` | string\|null | When validation passed |
| `agentLaunchedAt` | string\|null | When agent was launched |
| `task` | string\|null | Task description for the agent |
| `prNumber` | number\|null | Associated PR number if exists |
| `status` | string | `active`, `orphaned`, or `merged` |

**Port pool fields:**
| Field | Type | Description |
|-------|------|-------------|
| `start` | number | First port in pool (default: 8100) |
| `end` | number | Last port in pool (default: 8199) |
| `allocated` | number[] | Currently allocated ports |

## Manual Registry Operations

**Read entire registry:**
```bash
cat ~/.claude/worktree-registry.json | jq '.'
```

**List all worktrees:**
```bash
cat ~/.claude/worktree-registry.json | jq '.worktrees[]'
```

**List worktrees for specific project:**
```bash
cat ~/.claude/worktree-registry.json | jq '.worktrees[] | select(.project == "my-project")'
```

**Get allocated ports:**
```bash
cat ~/.claude/worktree-registry.json | jq '.portPool.allocated'
```

**Find worktree by branch (partial match):**
```bash
cat ~/.claude/worktree-registry.json | jq '.worktrees[] | select(.branch | contains("auth"))'
```

**Add worktree entry manually:**
```bash
TMP=$(mktemp)
jq '.worktrees += [{
  "id": "'$(uuidgen)'",
  "project": "my-project",
  "repoPath": "/path/to/repo",
  "branch": "feature/auth",
  "branchSlug": "feature-auth",
  "worktreePath": "/Users/me/tmp/worktrees/my-project/feature-auth",
  "ports": [8100, 8101],
  "createdAt": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'",
  "validatedAt": null,
  "agentLaunchedAt": null,
  "task": "My task",
  "prNumber": null,
  "status": "active"
}]' ~/.claude/worktree-registry.json > "$TMP" && mv "$TMP" ~/.claude/worktree-registry.json
```

**Remove worktree entry:**
```bash
TMP=$(mktemp)
jq 'del(.worktrees[] | select(.project == "my-project" and .branch == "feature/auth"))' \
  ~/.claude/worktree-registry.json > "$TMP" && mv "$TMP" ~/.claude/worktree-registry.json
```

**Release ports from pool:**
```bash
TMP=$(mktemp)
jq '.portPool.allocated = (.portPool.allocated | map(select(. != 8100 and . != 8101)))' \
  ~/.claude/worktree-registry.json > "$TMP" && mv "$TMP" ~/.claude/worktree-registry.json
```

**Initialize empty registry (if missing):**
```bash
mkdir -p ~/.claude
cat > ~/.claude/worktree-registry.json << 'EOF'
{
  "worktrees": [],
  "portPool": {
    "start": 8100,
    "end": 8199,
    "allocated": []
  }
}
EOF
```

## Manual Port Allocation

**Step 1: Get currently allocated ports**
```bash
ALLOCATED=$(cat ~/.claude/worktree-registry.json | jq -r '.portPool.allocated[]' | sort -n)
echo "Currently allocated: $ALLOCATED"
```

**Step 2: Find first available port**
```bash
for PORT in $(seq 8100 8199); do
  if ! echo "$ALLOCATED" | grep -q "^${PORT}$"; then
    if ! lsof -i :"$PORT" &>/dev/null; then
      echo "Available: $PORT"
      break
    fi
  fi
done
```

## Script Reference

Scripts are in `.agents/skills/worktree-manager/scripts/`

| Script | Usage |
|--------|-------|
| `allocate-ports.ps1` | `.\scripts\allocate-ports.ps1 -Count <count>` |
| `register.ps1` | `.\scripts\register.ps1 -Project <p> -Branch <b> ...` |
| `launch-agent.ps1` | `.\scripts\launch-agent.ps1 -WorktreePath <path>` |
| `status.ps1` | `.\scripts\status.ps1 [-Project <name>]` |
| `cleanup.ps1` | `.\scripts\cleanup.ps1 -Project <p> -Branch <b>` |
| `sync.ps1` | `.\scripts\sync.ps1` |
| `release-ports.ps1` | `.\scripts\release-ports.ps1 -Ports <p1>,<p2>` |

## Skill Config

Location: `~/.claude/skills/worktree-manager/config.json`

```json
{
  "terminal": "ghostty",
  "shell": "fish",
  "claudeCommand": "claude",
  "portPool": { "start": 8100, "end": 8199 },
  "portsPerWorktree": 2,
  "worktreeBase": "~/tmp/worktrees",
  "defaultCopyDirs": [".agents", ".env.example"]
}
```
