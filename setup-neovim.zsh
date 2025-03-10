header "SETUP NEOVIM"

# Build prerequisites
sudo apt-get install -y \
    ninja-build gettext cmake unzip curl build-essential python3-pip
python3.13 -m pip install cmake

# Neovim support packages
sudo apt-get -y install \
    xclip \
    ;
python3.13 -m pip install --upgrade pynvim neovim-remote

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

if [ "$CUR_TAG" != "stabl2e" ]; then
  echo "$CUR_TAG != 'stable' - updating"
  git checkout stable
  git clean -dfx
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  cd build
  cpack -G DEB
  sudo dpkg -i nvim-linux*.deb

  # Setup
  nvim --headless "+Lazy! sync" +qa
fi

cd "$old_dir"

