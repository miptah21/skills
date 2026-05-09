param(
    [Parameter(Mandatory=$true)][string]$Project,
    [Parameter(Mandatory=$true)][string]$Branch,
    [switch]$DeleteBranch
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"
if (-not (Test-Path $RegistryPath)) { exit }

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$Entry = $Registry.worktrees | Where-Object { $_.project -eq $Project -and $_.branch -eq $Branch }

if (-not $Entry) {
    Write-Host "Worktree not found in registry."
    exit
}

$Ports = @($Entry.ports)
$WorktreePath = $Entry.worktreePath
$RepoPath = $Entry.repoPath

# Kill processes on ports
foreach ($Port in $Ports) {
    try {
        $conns = Get-NetTCPConnection -LocalPort $Port -ErrorAction SilentlyContinue
        foreach ($c in $conns) { Stop-Process -Id $c.OwningProcess -Force -ErrorAction SilentlyContinue }
    } catch {}
}

# Remove worktree
if (Test-Path $WorktreePath) {
    Set-Location $RepoPath
    git worktree remove $WorktreePath --force
    git worktree prune
}

# Remove from registry and release ports
$Registry.worktrees = @($Registry.worktrees | Where-Object { $_.id -ne $Entry.id })
$Registry.portPool.allocated = @($Registry.portPool.allocated | Where-Object { $_ -notin $Ports })
$Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath

Write-Host "Cleaned up worktree $WorktreePath and released ports."

if ($DeleteBranch) {
    Set-Location $RepoPath
    git branch -D $Branch
    git push origin --delete $Branch
}
