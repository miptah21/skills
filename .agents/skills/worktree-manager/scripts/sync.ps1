# Simplified sync script
Write-Host "Syncing worktree registry..."
$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"
if (-not (Test-Path $RegistryPath)) { exit }

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$ValidWorktrees = @()
$AllocatedPorts = @()

foreach ($Tree in $Registry.worktrees) {
    if (Test-Path $Tree.worktreePath) {
        $ValidWorktrees += $Tree
        $AllocatedPorts += $Tree.ports
    } else {
        Write-Host "Removed stale entry: $($Tree.worktreePath)"
    }
}

$Registry.worktrees = $ValidWorktrees
$Registry.portPool.allocated = $AllocatedPorts | Sort-Object -Unique
$Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath
Write-Host "Sync complete."
