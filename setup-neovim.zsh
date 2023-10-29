header "SETUP NEOVIM"

NVIM_PATH="/usr/local/bin/nvim.appimage"

# Neovim support packages
sudo apt-get -y install \
    xclip \
    ;
python3 -m pip install --user --upgrade pynvim neovim-remote

if command -v npm >/dev/null && ! npm list -g --depth 0 neovim >/dev/null; then
    npm install -g neovim
fi

CONF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
mkdir -p "$CONF_DIR/undo"

latest_ver=$(curl -sS -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)

if [ ! hash nvim &> /dev/null ] || [ "$(nvim --version | head -n 1 | cut -d' ' -f2)" != "$latest_ver" ]; then
    sudo rm -rf "$NVIM_PATH"
    sudo curl -sS --create-dirs -L -o "$NVIM_PATH" \
        https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    sudo chmod +x "$NVIM_PATH"
    sudo ln -sf "$NVIM_PATH" "${NVIM_PATH%.appimage}"
fi

if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
  ln -s ~/.bbenv/nvchad ~/.config/nvim/lua/custom
fi
