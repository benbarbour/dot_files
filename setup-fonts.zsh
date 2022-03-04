if [ ! -f "$HOME/.local/share/fonts/Fira Code Regular Nerd Font Complete.otf" ] ; then
    curl -L -o /tmp/nerdfont.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
    unzip /tmp/nerdfont.zip -d "$HOME/.local/share/fonts"
    rm -f /tmp/nerdfont.zip
fi
