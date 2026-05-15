Write-Host "Uninstalling nalayak_beta..." -ForegroundColor Cyan

$INSTALL_DIR = "$HOME\.nalayak_beta"
$PROFILE_PATH = $PROFILE

if (Test-Path $PROFILE_PATH) {
    $content = Get-Content $PROFILE_PATH
    $newContent = $content | Where-Object { $_ -notmatch "# nalayak_beta hook" -and $_ -notmatch "\. `".*\\hooks\\hook\.ps1`"" }
    Set-Content -Path $PROFILE_PATH -Value $newContent
    Write-Host "Removed hook from $PROFILE_PATH" -ForegroundColor Green
}

if (Test-Path $INSTALL_DIR) {
    Remove-Item -Path $INSTALL_DIR -Recurse -Force
    Write-Host "Removed directory $INSTALL_DIR" -ForegroundColor Green
}

Write-Host "nalayak_beta uninstalled successfully. Restart your terminal." -ForegroundColor Green
