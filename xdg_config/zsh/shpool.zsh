# =============================================================================
# shpool session management
# =============================================================================

# Pick or create a shpool session
function shpool-pick() {
  local sessions
  sessions="$(shpool list 2>/dev/null | tail -n +2)"

  if [[ -n "$sessions" ]]; then
    echo "\nShpool sessions:"
    echo "$sessions" | nl -w2 -s') '
  else
    echo "No existing shpool sessions."
  fi

  echo
  local reply
  echo -n "Session name (number or name, empty to cancel): "
  if ! read -r reply; then
    return 0
  fi
  [[ -z "$reply" ]] && return 0

  # If numeric, extract session name from that line
  if [[ "$reply" == <-> ]]; then
    reply="$(echo "$sessions" | sed -n "${reply}p" | awk '{print $1}')"
    [[ -z "$reply" ]] && { echo "Invalid selection" >&2; return 1; }
  fi

  local cache_dir env_file
  cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/shpool"
  env_file="$cache_dir/ssh-${reply}.env"
  mkdir -p "$cache_dir"
  if [[ -n "$SSH_TTY$SSH_CONNECTION$SSH_CLIENT" ]]; then
    {
      printf 'SSH_TTY=%q\n' "$SSH_TTY"
      printf 'SSH_CONNECTION=%q\n' "$SSH_CONNECTION"
      printf 'SSH_CLIENT=%q\n' "$SSH_CLIENT"
    } >| "$env_file"
  else
    rm -f "$env_file"
  fi

  shpool attach --force "$reply"
}

# Notify on SSH login if sessions exist
if [[ -n "$SSH_TTY" && -z "$SHPOOL_SESSION_NAME" ]]; then
  local count
  count=$(shpool list 2>/dev/null | tail -n +2 | wc -l)
  (( count > 0 )) && echo "shpool: $count session(s) available (run 'shpool-pick' to attach)"
fi

# Sync SSH env into shpool sessions for starship's ssh module
if [[ -n "$SHPOOL_SESSION_NAME" ]]; then
  _shpool_sync_ssh_env() {
    local cache_dir env_file mtime
    cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/shpool"
    env_file="$cache_dir/ssh-${SHPOOL_SESSION_NAME}.env"
    if [[ -f "$env_file" ]]; then
      zmodload -F zsh/stat b:zstat 2>/dev/null
      if zstat -A _shpool_stat +mtime -- "$env_file" 2>/dev/null; then
        mtime="${_shpool_stat[1]}"
      fi
      if [[ "$mtime" != "$SHPOOL_SSH_ENV_MTIME" ]]; then
        set -a
        source "$env_file"
        set +a
        SHPOOL_SSH_ENV_MTIME="$mtime"
      fi
    else
      if [[ -n "$SHPOOL_SSH_ENV_MTIME" ]]; then
        unset SSH_TTY SSH_CONNECTION SSH_CLIENT
        SHPOOL_SSH_ENV_MTIME=""
      fi
    fi
  }

  add-zsh-hook precmd _shpool_sync_ssh_env
fi
