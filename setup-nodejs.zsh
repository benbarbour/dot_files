header "SETUP NODEJS"

mkdir -p "$NVM_DIR"
curl -sS -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
set +v
source "$HOME/.profile"
set -v

nvm install --lts
nvm alias default node

npm set init.author.name "Ben Barbour"
npm set init.author.email "ben.barbour@gmail.com"
npm set init.license "ISC"
npm set init.version "1.0.0"

command -v npx || npm install -g npx
