header "SETUP NEOVIM"

# Build prerequisites
sudo apt-get install ninja-build gettext cmake unzip curl build-essential ccache

# Neovim support packages
sudo apt-get -y install \
    xclip \
    ;
python3.13 -m pip install --user --upgrade pynvim neovim-remote

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
CUR_TAG=$(git name-rev --tags --name-only HEAD)

if [ "$CUR_TAG" != "stable" ]; then
  echo "$CUR_TAG != 'stable' - updating"
  git checkout stable
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  cd build
  cpack -G DEB
  sudo dpkg -i nvim-linux64.deb

  # Setup
  nvim --headless "+Lazy! sync" +qa
fi

cd "$old_dir"

