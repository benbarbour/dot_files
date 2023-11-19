header "SETUP FONTS"
if [ ! -f "$HOME/.termux/font.ttf" ] ; then
    curl -sS -L -o ./nerdfont.zip \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
    unzip ./nerdfont.zip "FiraCodeNerdFont-Regular.ttf" -d "$HOME/.termux/"
    mv "$HOME/.termux/FiraCodeNerdFont-Regular.ttf" "$HOME/.termux/font.ttf"
    rm ./nerdfont.zip
fi
