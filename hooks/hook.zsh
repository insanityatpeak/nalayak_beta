autoload -Uz add-zsh-hook

__nalayak_preexec() {
    __nalayak_last_cmd=$1
}

__nalayak_precmd() {
    local exit_code=$?
    if [[ -n "$__nalayak_last_cmd" ]]; then
        local is_success="False"
        if [[ $exit_code -eq 0 ]]; then
            is_success="True"
        fi
        python3 "$HOME/.nalayak_beta/nalayak_beta.py" "$__nalayak_last_cmd" $exit_code $is_success
    fi
    __nalayak_last_cmd=""
}

add-zsh-hook preexec __nalayak_preexec
add-zsh-hook precmd __nalayak_precmd
