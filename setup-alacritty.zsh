if ! command -v kitty ; then
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    sudo ln -sf "$HOME/.local/kitty.app/bin/kitty" /usr/bin/kitty
fi
