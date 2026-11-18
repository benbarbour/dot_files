header "SETUP FONTS"
font_dir="$HOME/.local/share/fonts"
font_stamp="$font_dir/.firacode-nerd-font-version"
font_ver=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
    https://github.com/ryanoasis/nerd-fonts/releases/latest)
font_ver="${font_ver##*/}"
if [ "$(cat "$font_stamp" 2>/dev/null)" != "$font_ver" ]; then
    curl -fsS -L -o /tmp/nerdfont.zip \
        "https://github.com/ryanoasis/nerd-fonts/releases/download/$font_ver/FiraCode.zip"
    mkdir -p "$font_dir"
    unzip -o -q /tmp/nerdfont.zip -d "$font_dir"
    rm -f /tmp/nerdfont.zip
    echo "$font_ver" > "$font_stamp"
fi
