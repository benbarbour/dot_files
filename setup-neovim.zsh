NVIM_PATH="/usr/local/bin/nvim.appimage"

# Neovim support packages
sudo apt-get -y install \
    xclip \
    ;
python3 -m pip install --user --upgrade pynvim

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if command -v npm >/dev/null; then
    npm install -g neovim
fi

CONF_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
mkdir -p "$CONF_DIR/backup"

if [ ! -f "$NVIM_PATH" ]; then
    sudo curl --create-dirs -L --output "$NVIM_PATH"\
        https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
fi

sudo chmod +x "$NVIM_PATH"
sudo ln -sf "$NVIM_PATH" "${NVIM_PATH%.appimage}"

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ ! -d "$PACKER_DIR" ]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
else
    git -C "$PACKER_DIR" fetch --depth 1
    git -C "$PACKER_DIR" reset --hard origin/master
    git -C "$PACKER_DIR" clean -dfx
fi

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim --headless -c 'UpdateRemotePlugins' -c 'qall'
