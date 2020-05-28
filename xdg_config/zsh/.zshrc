# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/src/powerlevel10k/powerlevel10k.zsh-theme

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=9999
setopt appendhistory
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt no_share_history
unsetopt share_history

for file in ~/.config/zsh/plugins/*.zsh; do
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

source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/.zshrc.local"
