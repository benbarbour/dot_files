header "SETUP NEOVIM"

NVIM_PATH="/usr/local/bin/nvim.appimage"

# Neovim support packages
python3 -m pip install --user --upgrade pynvim neovim-remote

if command -v npm >/dev/null && ! npm list -g --depth 0 neovim >/dev/null; then
    npm install -g neovim
fi

CONF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
mkdir -p "$CONF_DIR/undo"

if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  ln -s ~/.bbenv/nvchad ~/.config/nvim/lua/custom
fi
