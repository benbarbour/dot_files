() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
}

# Adds the given text to the prompt
# Takes optional arguments 'fg' and 'bg' for controlling the foreground and
# background color of the item.
prompt_item() {
  local fg="%f"
  local bg="%k"
  if [[ -n "$3" ]]; then
    bg="%K{$3}"
  fi
  if [[ -n "$2" ]]; then
    fg="%F{$2}"
  fi
  echo -n "$bg$fg"
  echo -n -e "$1"
  echo -n "%f%k%b "
}

prompt_sep() {
  echo -n " "
}

prompt_user_host() {
  local color='green'
  if [[ $UID -eq 0 ]]; then
    color='red'
  fi
  prompt_item "$terminfo[bold]%n@%m" $color
}

prompt_cur_dir() {
  prompt_item "%{$terminfo[bold]%}%~" blue
}

prompt_py_venv() {
  if [ ! -z "$VIRTUAL_ENV" ]; then
    prompt_item "‹py:$(basename ""$VIRTUAL_ENV"")›" 215
  fi
}

prompt_retval() {
  prompt_item "%(?..[↵%?])" red
}

ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
prompt_git() {
  prompt_item "‹$(git_prompt_info)›" yellow
}

build_prompt() {
  echo -e -n "╭─"
  prompt_user_host
  prompt_cur_dir
  prompt_py_venv
  prompt_git
  prompt_retval
  echo -e -n "\n╰─➤ "
}

PROMPT='%{%f%b%k%}$(build_prompt)'
