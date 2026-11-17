header "SETUP LUA"

if ! command -v luarocks >/dev/null; then
  sudo apt-get install -y lua5.1 liblua5.1-0 liblua5.1-dev

  rocks_ver="3.11.1"

  d=$(pwd)
  cd /tmp
  curl -sS -L -O https://luarocks.org/releases/luarocks-$rocks_ver.tar.gz
  tar zxpf luarocks-$rocks_ver.tar.gz
  cd luarocks-$rocks_ver
  ./configure && make && sudo make install
  rm /tmp/luarocks-$rocks_ver.tar.gz
  cd "$d"
fi
