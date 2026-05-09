param(
    [Parameter(Mandatory=$true)][string]$WorktreePath,
    [string]$Task = $null
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"

Write-Host "Launching agent in $WorktreePath..."
Start-Process powershell -ArgumentList "-NoExit","-Command","cd '$WorktreePath'"

if ($Task -and (Test-Path $RegistryPath)) {
    $Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
    $Entry = $Registry.worktrees | Where-Object { $_.worktreePath -eq $WorktreePath }
    if ($Entry) {
        $Entry.agentLaunchedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        $Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath
    }
}
