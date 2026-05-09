param(
    [string]$Project = $null
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"
if (-not (Test-Path $RegistryPath)) {
    Write-Host "No worktrees registered."
    exit 0
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$Trees = @($Registry.worktrees)

if ($Project) {
    $Trees = $Trees | Where-Object { $_.project -eq $Project }
}

if ($Trees.Count -eq 0) {
    Write-Host "No worktrees found."
    exit 0
}

$Trees | Format-Table project, branch, @{Name="ports";Expression={$_.ports -join ','}}, status, task -AutoSize
