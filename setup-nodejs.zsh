header "SETUP NODEJS"

npm config set init-author-name="Ben Barbour"
npm config set init-author-email="ben.barbour@gmail.com"
npm config set init-license="ISC"
npm config set init-version="1.0.0"

command -v npx || npm install -g npx
