ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"

typeset -U path
path=($HOME/bin
      /usr/local/go/bin
      $GOPATH/bin
      $path)
export PATH
