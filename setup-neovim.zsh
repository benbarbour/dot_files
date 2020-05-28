NVIM_PATH="/usr/local/bin/nvim.appimage"

# Neovim support packages
sudo apt-get -y install \
    python3-pip \
    xclip \
    ;
pip3 install --user --upgrade pynvim

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

if [ ! -f "$CONF_DIR/site/autoload/plug.vim" ]; then
    curl --create-dirs -fL \
        -o "$CONF_DIR/site/autoload/plug.vim" \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

sudo chmod +x "$NVIM_PATH"
sudo ln -sf "$NVIM_PATH" "${NVIM_PATH%.appimage}"

nvim --headless +PlugInstall +PlugUpdate +PlugUpgrade +UpdateRemotePlugins +qa
