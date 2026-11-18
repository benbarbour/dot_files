header "SETUP LUA"

rocks_ver=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
    https://github.com/luarocks/luarocks/releases/latest)
rocks_ver="${rocks_ver##*/v}"
rocks_bin=$(command -v luarocks || true)

# A luarocks that came from apt is left for apt to upgrade.
if [ -n "$rocks_bin" ] && dpkg -S "$rocks_bin" >/dev/null 2>&1; then
  :
elif [ "$(luarocks --version 2>/dev/null | head -n 1)" != "$rocks_bin $rocks_ver" ]; then
  sudo apt-get install -y lua5.1 liblua5.1-0 liblua5.1-dev

  d=$(pwd)
  cd /tmp
  curl -fsS -L -O https://luarocks.org/releases/luarocks-$rocks_ver.tar.gz
  tar zxpf luarocks-$rocks_ver.tar.gz
  cd luarocks-$rocks_ver
  ./configure && make && sudo make install
  rm /tmp/luarocks-$rocks_ver.tar.gz
  cd "$d"
fi
