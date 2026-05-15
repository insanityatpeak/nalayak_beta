function __nalayak_postexec --on-event fish_postexec
    set -l last_status $status
    set -l last_cmd $argv
    set -l is_success "False"
    if test $last_status -eq 0
        set is_success "True"
    end
    python3 "$HOME/.nalayak_beta/nalayak_beta.py" "$last_cmd" $last_status $is_success
end
