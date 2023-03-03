header "SETUP NODEJS"

mkdir -p "$NVM_DIR"
curl -sS -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
set +v
source "$HOME/.profile"
set -v

nvm install --lts
nvm alias default node

npm config set init-author-name="Ben Barbour"
npm config set init-author-email="ben.barbour@gmail.com"
npm config set init-license="ISC"
npm config set init-version="1.0.0"

command -v npx || npm install -g npx
