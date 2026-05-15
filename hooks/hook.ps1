if (-not $global:__Nalayak_OldPrompt) {
    $global:__Nalayak_OldPrompt = $function:prompt
}
function prompt {
    $success = $?
    $exitCode = $LASTEXITCODE
    $lastRecord = Get-History -Count 1
    if ($lastRecord) {
        # Temporarily force UTF-8 to prevent garbled text
        $oldOut = $OutputEncoding
        $oldCon = [Console]::OutputEncoding
        $OutputEncoding = [System.Text.Encoding]::UTF8
        [Console]::OutputEncoding = [System.Text.Encoding]::UTF8

        # Run and force output to the console so it doesn't get swallowed by the prompt string
        python "$HOME\.nalayak_beta\nalayak_beta.py" "$($lastRecord.CommandLine)" $exitCode $success | Out-Host

        $OutputEncoding = $oldOut
        [Console]::OutputEncoding = $oldCon
    }
    # Invoke old prompt
    & $global:__Nalayak_OldPrompt
}
