__nalayak_preexec() {
    __nalayak_last_cmd=$BASH_COMMAND
}
trap '__nalayak_preexec' DEBUG

__nalayak_postexec() {
    local exit_code=$?
    if [ -n "$__nalayak_last_cmd" ] && [[ "$__nalayak_last_cmd" != *"__nalayak_preexec"* ]]; then
        local is_success="False"
        if [ $exit_code -eq 0 ]; then
            is_success="True"
        fi
        python3 "$HOME/.nalayak_beta/nalayak_beta.py" "$__nalayak_last_cmd" $exit_code $is_success
    fi
}
PROMPT_COMMAND="__nalayak_postexec; $PROMPT_COMMAND"
