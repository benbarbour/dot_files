#!/bin/bash

function ask() {
  # https://djm.me/ask
  local prompt default REPLY

  while true; do

    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read REPLY </dev/tty

    # Default?
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi

    # Check if the reply is valid
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

function elementIn() {
  # https://stackoverflow.com/a/8574392
  local e
  for e in "${@:2}"; do [[ "$e" == "$1"  ]] && return 0; done
  return 1
}

if ask "Install debian packages?" N; then
  sudo apt install \
    htop \
    ctags \
    tree \
    curl \
    python-pip python3-pip \
    python3-venv \
    neovim \
    git \
    coreutils \
    boxes \
    figlet \
    silversearcher-ag \
    ;
  echo -e "done installing debian packages\n\n"
fi

if ask "Install pip packages?" N; then
  pip install \
    git-review \
    isort \
    paramiko \
    pep8 \
    polib \
    prettytable \
    pylint \
    scp \
    neovim \
    ;

  pip3 install \
    pylint \
    neovim \
    neovim-remote \
    psutil \
    ;
  echo -e "done installing pip packages\n\n"
fi

if ask "Install oh-my-zsh?" N; then
  sudo sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo -e "done installing oh-my-zsh\n\n"
fi

if [[ "$SHELL" != *"zsh"* ]] && ask "Change to zsh?" N; then
  chsh -s $(which zsh)
  echo -e "done switching to zsh\n\n"
fi

if ask "Install/update diff-so-fancy?" N; then
  dest="bin/diff-so-fancy"
  wget -O $dest https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
  chmod +x $dest
  echo -e "done installing diff-so-fancy\n\n"
fi

if ask "Install/update symlinks?" N; then
  me="$(basename $0)"
  excluded=($me "README.md" ".gitignore" "config" "oh-my-zsh")

  links=("config/nvim" "oh-my-zsh/custom")
  for f in *; do
    if ! elementIn $f "${excluded[@]}"; then
      links+=($f)
    fi
  done

  echo "These links will be created:"
  for link in ${links[*]}; do
    printf "%-35s\t-> %s\n" "$HOME/.$link" "$(realpath $link)"
  done

  if ask "Are you sure?" Y; then
    for link in ${links[*]}; do
      if [ -d "$HOME/.$link" ]; then
        rm -r -f -I -v "$HOME/.$link"
      fi
      ln -n -s -f -T "$(realpath $link)" "$HOME/.$link"
    done
  fi

  # These files are sourced by checked in files, but are not intended to be checked in.
  touch ~/.zshrc.local
  touch ~/.config/nvim/config/local.vim

  echo -e "done creating symlinks\n\n"
fi
