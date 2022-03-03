curl -L -o /tmp/nerdfont.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip /tmp/nerdfont.zip -o -d "$HOME/.local/share/fonts"
rm -f /tmp/nerdfont.zip
