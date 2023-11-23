HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=9999
setopt appendhistory
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt no_share_history
unsetopt share_history

for file in ~/.config/zsh/plugins/*.zsh(N); do
    source "$file"
done

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias cat='bat'
alias fd='fd --follow'
alias ll='ls -l'
alias ls='exa --icons --group-directories-first'
alias ps='echo "Consider using procs instead!\n"; ps'
alias sed='echo "Consider using sd instead!\n"; sed'
alias top='top; echo "Consider using ytop next time!\n"'
alias tree='exa --tree --icons'

export SKIM_DEFAULT_COMMAND='fd --type f'

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

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

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc.local" ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc.local"
fi

eval "$(starship init zsh)"

typeset -U path

export SYSTEMD_EDITOR=nvim

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"
