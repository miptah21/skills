param(
    [Parameter(Mandatory=$true)][string]$Project,
    [Parameter(Mandatory=$true)][string]$Branch,
    [Parameter(Mandatory=$true)][string]$BranchSlug,
    [Parameter(Mandatory=$true)][string]$WorktreePath,
    [Parameter(Mandatory=$true)][string]$RepoPath,
    [Parameter(Mandatory=$true)][string]$Ports,
    [string]$Task = $null
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"

if (-not (Test-Path $RegistryPath)) {
    $NewRegistry = @{
        worktrees = @()
        portPool = @{ start = 8100; end = 8199; allocated = @() }
    }
    New-Item -Path (Split-Path $RegistryPath) -ItemType Directory -Force | Out-Null
    $NewRegistry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
if ($null -eq $Registry.worktrees) { $Registry.worktrees = @() }

$Existing = $Registry.worktrees | Where-Object { $_.project -eq $Project -and $_.branch -eq $Branch }

if ($Existing) {
    Write-Host "Warning: Worktree already registered, updating..."
    $OldPorts = $Existing.ports
    $Registry.worktrees = @($Registry.worktrees | Where-Object { -not ($_.project -eq $Project -and $_.branch -eq $Branch) })
    
    if ($OldPorts) {
        $Registry.portPool.allocated = @($Registry.portPool.allocated | Where-Object { $_ -notin $OldPorts })
        Write-Host "Released old ports: $($OldPorts -join ',')"
    }
}

$PortsArray = @($Ports -split ',' | ForEach-Object { [int]$_ })
$Uuid = [guid]::NewGuid().ToString()
$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$NewEntry = @{
    id = $Uuid
    project = $Project
    repoPath = $RepoPath
    branch = $Branch
    branchSlug = $BranchSlug
    worktreePath = $WorktreePath
    ports = $PortsArray
    createdAt = $Timestamp
    validatedAt = $null
    agentLaunchedAt = $null
    task = $Task
    prNumber = $null
    status = "active"
}

$Registry.worktrees += $NewEntry
$Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath

Write-Host "✅ Registered worktree:"
Write-Host "   Project: $Project"
Write-Host "   Branch: $Branch"
Write-Host "   Path: $WorktreePath"
Write-Host "   Ports: $Ports"
if ($Task) { Write-Host "   Task: $Task" }
