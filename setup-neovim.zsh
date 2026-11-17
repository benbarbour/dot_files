header "SETUP NEOVIM"

# Build prerequisites
sudo apt-get install -y \
    ninja-build gettext cmake unzip curl build-essential python3-pip
python3.13 -m pip install cmake

# Neovim support packages
sudo apt-get -y install \
    xclip \
    ;
# The python provider gets its own venv so it doesn't follow `pyenv
# global` or whatever venv a project activates (see config/options.lua).
NVIM_VENV="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/python-venv"
[ -x "$NVIM_VENV/bin/python" ] || python3.13 -m venv --clear "$NVIM_VENV"
"$NVIM_VENV/bin/python" -m pip install --upgrade pynvim

# nvr is a command you run, so it stays on PATH via pyenv's shims.
python3.13 -m pip install --upgrade neovim-remote

if command -v npm >/dev/null && ! npm list -g --depth 0 neovim >/dev/null; then
    npm install -g neovim
fi

# Clone and build
old_dir=$(pwd)
mkdir -p $HOME/src
if [ ! -d $HOME/src/neovim ]; then
    git clone https://github.com/neovim/neovim.git $HOME/src/neovim
fi
cd $HOME/src/neovim

git fetch --prune --tags --force
git checkout --quiet stable
STABLE_VER=$(git tag --points-at stable 'v*' | head -n 1)
CUR_VER=$(nvim --version 2>/dev/null | head -n 1)

if [ "$CUR_VER" != "NVIM $STABLE_VER" ]; then
  echo "'$CUR_VER' != 'NVIM $STABLE_VER' - updating"
  git clean -dfx
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  cd build
  cpack -G DEB
  # Ubuntu splits the runtime into its own package, and dpkg won't let our deb overwrite it.
  if dpkg -s neovim-runtime >/dev/null 2>&1; then
    sudo apt-get -y remove neovim-runtime
  fi
  sudo dpkg -i nvim-linux*.deb

  # Setup
  nvim --headless "+Lazy! sync" +qa
fi

cd "$old_dir"

