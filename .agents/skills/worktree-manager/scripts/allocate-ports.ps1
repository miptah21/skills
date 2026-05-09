param(
    [int]$Count = 2
)

$RegistryPath = "$env:USERPROFILE\.gemini\antigravity\worktree-registry.json"
$ConfigPath = "$PSScriptRoot\..\config.json"

$PortStart = 8100
$PortEnd = 8199

if (Test-Path $ConfigPath) {
    $Config = Get-Content $ConfigPath | ConvertFrom-Json
    if ($Config.portPool) {
        $PortStart = $Config.portPool.start
        $PortEnd = $Config.portPool.end
    }
}

if (-not (Test-Path $RegistryPath)) {
    $NewRegistry = @{
        worktrees = @()
        portPool = @{
            start = $PortStart
            end = $PortEnd
            allocated = @()
        }
    }
    New-Item -Path (Split-Path $RegistryPath) -ItemType Directory -Force | Out-Null
    $NewRegistry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath
}

$Registry = Get-Content $RegistryPath -Raw | ConvertFrom-Json
$Allocated = @($Registry.portPool.allocated)

$FoundPorts = @()

for ($port = $PortStart; $port -le $PortEnd; $port++) {
    if ($Allocated -contains $port) { continue }
    
    # Check if port is in use
    $inUse = $false
    try {
        $tcpConnection = Get-NetTCPConnection -LocalPort $port -ErrorAction Stop
        $inUse = $true
    } catch {
        $inUse = $false
    }
    
    if (-not $inUse) {
        $FoundPorts += $port
        if ($FoundPorts.Count -eq $Count) { break }
    }
}

if ($FoundPorts.Count -lt $Count) {
    Write-Error "Could not find $Count available ports in range $PortStart-$PortEnd"
    exit 1
}

$Registry.portPool.allocated = ($Allocated + $FoundPorts) | Sort-Object -Unique
$Registry | ConvertTo-Json -Depth 5 | Set-Content $RegistryPath

Write-Output ($FoundPorts -join " ")
