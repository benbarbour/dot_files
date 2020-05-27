ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

typeset -U path
path=($HOME/bin
      $path)
export PATH
