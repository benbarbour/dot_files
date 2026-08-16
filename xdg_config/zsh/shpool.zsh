# =============================================================================
# shpool session management
# =============================================================================

_shpool_cache_dir() { print -r -- "${XDG_CACHE_HOME:-$HOME/.cache}/shpool" }

# Fail loudly if a required command is missing (installed via the .bbenv setup).
_shpool_require() {
  local cmd missing=()
  for cmd in "$@"; do
    command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
  done
  if (( ${#missing} )); then
    print -u2 -- "shpool.zsh: missing required command(s): ${missing[*]}"
    print -u2 -- "  install them by running the .bbenv setup (e.g. ./setup or setup-go.zsh)"
    return 1
  fi
}

# Attach to a session, recording the SSH env (for starship) and the
# last-used session name (for shpool-resume). Creates the session if needed.
_shpool_attach() {
  local name="$1" cache_dir env_file
  cache_dir="$(_shpool_cache_dir)"
  mkdir -p "$cache_dir"

  # shpool rejects blank names and names containing whitespace — but it does so
  # with a message and exit status 0, so a bad name silently drops you back
  # into the shell you started from. Validate/normalize here instead.
  local requested="$name"
  name="${(j:-:)${=name}}"   # split on whitespace, rejoin with '-' (also trims)
  if [[ -z "$name" ]]; then
    print -u2 -- "shpool: blank session names are not allowed."
    return 1
  fi
  if [[ "$name" != "$requested" ]]; then
    print -u2 -- "shpool: whitespace is not allowed in session names — using '$name'."
  fi

  env_file="$cache_dir/ssh-${name}.env"
  if [[ -n "$SSH_TTY$SSH_CONNECTION$SSH_CLIENT" ]]; then
    {
      printf 'SSH_TTY=%q\n' "$SSH_TTY"
      printf 'SSH_CONNECTION=%q\n' "$SSH_CONNECTION"
      printf 'SSH_CLIENT=%q\n' "$SSH_CLIENT"
    } >| "$env_file"
  else
    rm -f "$env_file"
  fi

  print -r -- "$name" >| "$cache_dir/last-session"
  shpool attach --force "$name"

  # If this client is detached because another device steals the session
  # (shpool attach --force, above), the program running inside never gets to
  # tear down the terminal modes it enabled — mouse/focus reporting, bracketed
  # paste, the alternate screen. The emulator then keeps emitting input escape
  # codes (the "random characters and semicolons") at the bare prompt. Now that
  # control is back in the shell, scrub those modes so the terminal is sane.
  printf '\e[?1049l\e[?1000l\e[?1002l\e[?1003l\e[?1004l\e[?1006l\e[?2004l\e[?25h\e[0m'
}

# Names of the currently running sessions, one per line.
_shpool_session_names() { shpool list 2>/dev/null | tail -n +2 | cut -f1 }

# Resume the most recently attached session in one step.
function shpool-resume() {
  _shpool_require shpool || return 1
  local last
  last="$(<"$(_shpool_cache_dir)/last-session")" 2>/dev/null
  if [[ -z "$last" ]]; then
    print -u2 -- "shpool: no previous session recorded — run 'shpool-pick'."
    return 1
  fi
  if ! _shpool_session_names | grep -qxF -- "$last"; then
    print -u2 -- "shpool: last session '$last' is gone — recreating it."
  fi
  _shpool_attach "$last"
}

# Pick, resume, or create a shpool session via a gum menu.
function shpool-pick() {
  _shpool_require shpool gum || return 1

  local cache_dir sessions
  cache_dir="$(_shpool_cache_dir)"
  sessions="$(shpool list 2>/dev/null | tail -n +2)"
  sessions="${sessions%$'\n'}"

  local -a names
  names=()
  [[ -n "$sessions" ]] && names=("${(@f)$(print -r -- "$sessions" | cut -f1)}")

  # Prune cached SSH env for sessions that no longer exist.
  local f base
  for f in "$cache_dir"/ssh-*.env(N); do
    base="${${f:t}#ssh-}"; base="${base%.env}"
    [[ -n "${names[(r)$base]}" ]] || rm -f "$f"
  done

  # Most-recently attached session, if it still exists (the cursor lands here,
  # so pressing Enter resumes it).
  local last last_default=""
  last="$(<"$cache_dir/last-session")" 2>/dev/null
  [[ -n "$last" && -n "${names[(r)$last]}" ]] && last_default="$last"

  local reply=""

  if [[ -z "$sessions" ]]; then
    reply="$(gum input --header 'New shpool session' --placeholder 'session name')" || return 0
  else
    # Build an aligned menu; remember the row for the last session so the
    # cursor can start there.
    local -a menu sel_args
    local name started state when opt def_opt='' w=4 n
    for n in "$names[@]"; do (( ${#n} > w )) && w=${#n}; done
    while IFS=$'\t' read -r name started state; do
      when="${started[1,16]}"; when="${when/T/ }"
      opt="$(printf '%-*s  │  %-12s  │  %s' "$w" "$name" "$state" "$when")"
      menu+=("$opt")
      [[ "$name" == "$last_default" ]] && def_opt="$opt"
    done <<< "$sessions"
    menu+=('＋  New session…')

    [[ -n "$def_opt" ]] && sel_args=(--selected "$def_opt")
    opt="$(print -rl -- "$menu[@]" \
      | gum choose --header 'shpool — pick a session  (↵ on highlighted = resume last)' "$sel_args[@]")" \
      || return 0
    [[ -z "$opt" ]] && return 0

    local idx=${menu[(ie)$opt]}
    if (( idx >= 1 && idx <= ${#names} )); then
      reply="${names[idx]}"
    else
      reply="$(gum input --header 'New shpool session' --placeholder 'session name')" || return 0
    fi
  fi

  [[ -z "$reply" ]] && return 0
  _shpool_attach "$reply"
}

# Notify on SSH login if sessions exist.
if [[ -n "$SSH_TTY" && -z "$SHPOOL_SESSION_NAME" ]]; then
  local _list
  _list="$(shpool list 2>/dev/null | tail -n +2)"
  if [[ -n "${_list%$'\n'}" ]]; then
    local _total _detached
    _total=$(print -r -- "$_list" | grep -c .)
    _detached=$(print -r -- "$_list" | awk -F'\t' '$3 != "attached"' | grep -c .)
    print -r -- "shpool: $_total session(s) available ($_detached detached) — 'shpool-pick' to choose, 'shpool-resume' for last"
  fi
  unset _list _total _detached
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

  # add-zsh-hook is an autoloaded function; ensure it's available regardless of
  # whether anything earlier in the rc has loaded it (a freshly created shpool
  # session may source this before it's autoloaded otherwise).
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _shpool_sync_ssh_env
fi
