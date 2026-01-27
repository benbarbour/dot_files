HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=9999
setopt appendhistory
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt no_share_history
unsetopt share_history

autoload -Uz compinit
compinit

for file in ~/.config/zsh/plugins/*.zsh(N); do
    source "$file"
done

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias cat='bat'
alias fd='fd --follow'
alias ll='ls -l'
alias ls='exa --icons --group-directories-first'
alias tree='exa --tree --icons'

export SKIM_DEFAULT_COMMAND='fd --type f'

export VISUAL=nvim
export EDITOR=nvim

function new-node-project() {
  echo $CWD
  pwd
  if [ -f LICENSE ]; then
    echo "Skipping LICENSE generation because file already exists"
  else
    npx license $(npm get init.license) -o "$(npm get init.author.name)" > LICENSE
  fi
  if [ -f .gitignore ]; then
    echo "Skipping gitignore generation because file already exists"
  else
    npx gitignore node
  fi
  npm init -y
}

eval "$(starship init zsh)"

typeset -U path

export SYSTEMD_EDITOR=nvim

autoload -U bashcompinit
bashcompinit

# fnm
FNM_PATH="/home/ben/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/ben/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc.local" ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc.local"
fi

eval "$(task --completion zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# Auto-activate venv if in a subdirectory and VIRTUAL_ENV is set in parent
if [[ -n "$VIRTUAL_ENV" ]] && [[ -z "$VIRTUAL_ENV_ACTIVATED" ]]; then
    export VIRTUAL_ENV_ACTIVATED=1
    source "$VIRTUAL_ENV/bin/activate"
fi
