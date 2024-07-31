ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"

export PATH="$HOME/bin:$(python3 -m site --user-base)/bin:/usr/local/go/bin:$GOPATH/bin:$CARGO_HOME/bin:$PATH"
