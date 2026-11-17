ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

# setup sources this from bash, which has no -U
[ -n "$ZSH_VERSION" ] && typeset -U path PATH

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$GOPATH/bin:$CARGO_HOME/bin:$PATH"

# Each fnm env makes a new multishell dir, so a child shell keeps the one it inherited.
# setup sources this from bash, and fnm would guess zsh from the parent process
if [ ! -d "$FNM_MULTISHELL_PATH" ] && command -v fnm >/dev/null; then
    eval "$(fnm env --shell "$([ -n "$ZSH_VERSION" ] && echo zsh || echo bash)")"
fi
