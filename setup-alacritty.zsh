header "SETUP ALACRITTY"

[ find /etc/apt/ -name '*.list' | xargs cat | grep '^[[:space:]]*deb' | grep -q 'mmstick76/alacritty' ] && sudo add-apt-repository -y ppa:mmstick76/alacritty

sudo apt-get -y install alacritty
