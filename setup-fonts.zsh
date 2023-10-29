header "SETUP FONTS"
if [ ! -f "$HOME/.local/share/fonts/Fira Code Regular Nerd Font Complete.otf" ] ; then
    curl -sS -L -o /tmp/nerdfont.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
    unzip /tmp/nerdfont.zip -d "$HOME/.local/share/fonts"
    rm -f /tmp/nerdfont.zip
fi
