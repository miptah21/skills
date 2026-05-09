param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)][int[]]$Ports
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"
if (-not (Test-Path $RegistryPath)) { exit 0 }

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$Registry.portPool.allocated = @($Registry.portPool.allocated | Where-Object { $_ -notin $Ports })
$Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath
Write-Host "Released ports: $($Ports -join ' ')"
