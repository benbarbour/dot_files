sudo apt-get -y install font-manager

if font-manager -l | grep -q "MesloLGS NF" ; then
    exit 0
fi

P10KFONT_DIR="/tmp/p10kfonts"
mkdir -p "$P10KFONT_DIR"
(cd "$P10KFONT_DIR" && \
    curl -Z -L \
       -o 1.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \
       -o 2.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf \
       -o 3.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf \
       -o 4.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf \
)
font-manager -i "$P10KFONT_DIR"/*.ttf
rm -rf "$P10KFONT_DIR"
