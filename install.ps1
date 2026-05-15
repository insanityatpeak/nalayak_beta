$ErrorActionPreference = "Stop"
Write-Host "Installing nalayak_beta..." -ForegroundColor Cyan

$INSTALL_DIR = "$HOME\.nalayak_beta"
$SRC_DIR = $PSScriptRoot

if (-not (Test-Path $INSTALL_DIR)) {
    New-Item -ItemType Directory -Path $INSTALL_DIR | Out-Null
}

Copy-Item -Path "$SRC_DIR\*" -Destination $INSTALL_DIR -Recurse -Force

# Hook for PowerShell profile
$PROFILE_PATH = $PROFILE
if (-not (Test-Path $PROFILE_PATH)) {
    $PROFILE_DIR = Split-Path $PROFILE_PATH
    if (-not (Test-Path $PROFILE_DIR)) {
        New-Item -ItemType Directory -Path $PROFILE_DIR | Out-Null
    }
    New-Item -ItemType File -Path $PROFILE_PATH -Force | Out-Null
}

$HOOK_SCRIPT = "$INSTALL_DIR\hooks\hook.ps1"
$HOOK_LINE = ". `"$HOOK_SCRIPT`""

$profileContent = Get-Content $PROFILE_PATH -ErrorAction SilentlyContinue
if ($null -eq $profileContent -or $profileContent -notcontains $HOOK_LINE) {
    Add-Content -Path $PROFILE_PATH -Value "`n# nalayak_beta hook`n$HOOK_LINE"
    Write-Host "Hook added to $PROFILE_PATH" -ForegroundColor Green
}

Write-Host "nalayak_beta installed successfully! Restart your terminal." -ForegroundColor Green
