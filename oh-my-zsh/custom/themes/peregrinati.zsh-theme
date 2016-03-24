# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# make some aliases for the colours: (coud use normal escap.seq's too)
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
  eval PR_$color='%{$fg[${(L)color}]%}'
done
eval PR_NO_COLOR="%{$terminfo[sgr0]%}"
eval PR_BOLD="%{$terminfo[bold]%}"

# Check the UID
if [[ $UID -ge 1000 ]]; then # normal user
  eval PR_USER='$PR_BOLD${PR_GREEN}%n${PR_NO_COLOR}'
  eval PR_USER_OP='$PR_BOLD${PR_GREEN}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_BOLD$PR_NO_COLOR➢ $PR_NO_COLOR'
elif [[ $UID -eq 0 ]]; then # root
  eval PR_USER='$PR_BOLD${PR_RED}%n${PR_NO_COLOR}'
  eval PR_USER_OP='$PR_BOLD${PR_RED}%#${PR_NO_COLOR}'
  local PR_PROMPT='$PR_BOLD$PR_RED➢ $PR_NO_COLOR'
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
  eval PR_HOST='$PR_BOLD${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
else
  eval PR_HOST='$PR_BOLD${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
fi

local sep_clr="$FG[243]"
local sep="$sep_clr├┈┤%{$PR_NO_COLOR%}"

local return_code="%(?..┤%{$PR_RED%}↵%?%{$PR_NO_COLOR%})"

local user_host='${PR_USER}${PR_BOLD}${PR_CYAN}@${PR_HOST}'
local current_dir='$sep%{$PR_BOLD$PR_YELLOW%}%d%{$PR_NO_COLOR%}'
local git_branch='$(git_prompt_info)%{$PR_NO_COLOR%}'

local jobs="%(1j.$sep$PR_BOLD$PR_MAGENTA%j job%(2j.s.)$PR_NO_COLOR.)"

PROMPT="
$sep_clr╭┤${user_host}${current_dir}${jobs}${rvm_ruby}${git_branch}$sep_clr├┈╼
$sep_clr╰┈${return_code}$sep_clr┤$PR_PROMPT"
RPS1=""

ZSH_THEME_GIT_PROMPT_PREFIX="$sep%{$PR_YELLOW%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="›%{$PR_NO_COLOR%}"
