header "CONFIGURE GIT"

prompt_gitconf() {
    if [ -n "$(git config --file xdg_config/git/config.local "$1")" ]; then
        return 0
    fi
    printf 'Enter your git %s: ' "$1"
    read x
    if [ ! -z "$x" ]; then
        git config --file xdg_config/git/config.local "$1" "$x"
    fi
}

prompt_gitconf "user.name"
prompt_gitconf "user.email"
