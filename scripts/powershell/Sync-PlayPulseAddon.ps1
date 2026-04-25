param(
    [string]$TargetProjectPath,
    [string]$PlayPulseRepoPath = (Join-Path $PSScriptRoot "..\\..\\..\\playpulse"),
    [string]$SourceAddonPath = "",
    [switch]$InstallAutoload
)

$ErrorActionPreference = "Stop"

if ($SourceAddonPath -eq "") {
    $SourceAddonPath = Join-Path $PlayPulseRepoPath "sdk\\godot\\playpulse\\addons\\playpulse"
}

if (-not (Test-Path $TargetProjectPath)) {
    throw "Target project path does not exist: $TargetProjectPath"
}

if (-not (Test-Path $SourceAddonPath)) {
    throw "Source addon path does not exist: $SourceAddonPath"
}

$targetProjectItem = Get-Item -LiteralPath $TargetProjectPath
$existingAddonsDir = Get-ChildItem -LiteralPath $targetProjectItem.FullName -Directory |
    Where-Object { $_.Name -ceq "Addons" } |
    Select-Object -First 1
if ($null -eq $existingAddonsDir) {
    $existingAddonsDir = Get-ChildItem -LiteralPath $targetProjectItem.FullName -Directory |
        Where-Object { $_.Name -ceq "addons" } |
        Select-Object -First 1
}

$targetAddonsDir = if ($null -ne $existingAddonsDir) {
    $existingAddonsDir.FullName
} else {
    Join-Path $targetProjectItem.FullName "addons"
}

$targetAddonPath = Join-Path $targetAddonsDir "playpulse"

New-Item -ItemType Directory -Path $targetAddonsDir -Force | Out-Null

if (Test-Path $targetAddonPath) {
    Remove-Item -LiteralPath $targetAddonPath -Recurse -Force
}

Copy-Item -LiteralPath $SourceAddonPath -Destination $targetAddonPath -Recurse -Force
Write-Host "Synced PlayPulse addon to $targetAddonPath"

if ($InstallAutoload) {
    $projectFile = Join-Path $TargetProjectPath "project.godot"
    if (-not (Test-Path $projectFile)) {
        throw "Godot project file does not exist: $projectFile"
    }

    $content = @(Get-Content -LiteralPath $projectFile)
    $filtered = @($content | Where-Object { $_ -notmatch '^PlayPulse=' })

    $autoloadIndex = [Array]::IndexOf($filtered, "[autoload]")
    if ($autoloadIndex -lt 0) {
        $filtered += ""
        $filtered += "[autoload]"
        $autoloadIndex = [Array]::IndexOf($filtered, "[autoload]")
    }

    $autoloadPath = if ((Split-Path -Leaf $targetAddonsDir) -ceq "Addons") {
        "res://Addons/playpulse/playpulse.gd"
    } else {
        "res://addons/playpulse/playpulse.gd"
    }
    $playPulseAutoload = "PlayPulse=`"*${autoloadPath}`""

    $before = @()
    $after = @()
    if ($autoloadIndex -ge 0) {
        $before = @($filtered[0..$autoloadIndex])
    }
    if ($autoloadIndex + 1 -lt $filtered.Count) {
        $after = @($filtered[($autoloadIndex + 1)..($filtered.Count - 1)])
    }

    $updated = @($before + $playPulseAutoload + $after)
    Set-Content -LiteralPath $projectFile -Value $updated
    Write-Host "Installed PlayPulse autoload in $projectFile"
}
