if command -v go >/dev/null; then
    printf 'go is already installed at: %s\n' "$(which go)"
else
    curl -L https://dl.google.com/go/$(curl 'https://golang.org/VERSION?m=text').linux-amd64.tar.gz -o /tmp/go.tar.gz
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
fi
