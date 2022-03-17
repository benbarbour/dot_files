header "CONFIGURE GIT"

prompt_gitconf() {
    printf 'Enter your git %s [%s]: ' "$1" "$(git config --file xdg_config/git/config.local $1)"
    read x
    if [ ! -z "$x" ]; then
        git config --file xdg_config/git/config.local "$1" "$x"
    fi
}

prompt_gitconf "user.name"
prompt_gitconf "user.email"
