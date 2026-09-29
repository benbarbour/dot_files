ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

export PATH="$HOME/bin:$(python3 -m site --user-base)/bin:/usr/local/go/bin:$GOPATH/bin:$CARGO_HOME/bin:$PATH"

# fnm (node)
export PATH="$HOME/.local/share/fnm:$PATH"
# setup sources this from bash, and fnm would guess zsh from the parent process
if command -v fnm >/dev/null; then
    eval "$(fnm env --shell "$([ -n "$ZSH_VERSION" ] && echo zsh || echo bash)")"
fi
