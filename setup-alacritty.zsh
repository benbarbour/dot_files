header "SETUP ALACRITTY"

pkg install \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    libxcb-xfixes0-dev \
    libxkbcommon-dev \
    python3

pushd $HOME/src
if [ -d alacritty ]; then
    cd alacritty
    git pull
else
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
fi

cargo build --release && ln -f -s /home/ben/src/alacritty/target/release/alacritty /home/ben/bin/alacritty

echo """[Desktop Entry]
Name=Alacritty
Exec=/home/ben/src/alacritty/target/release/alacritty
Terminal=false
Icon=/home/ben/src/alacritty/alacritty/windows/alacritty.ico
Type=Application
Comment=Terminal written in rust
""" > $HOME/.local/share/applications/alacritty.desktop

popd
