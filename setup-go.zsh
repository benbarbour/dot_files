header "SETUP GO"

update_needed=0
latest_ver=$(curl -sS 'https://go.dev/VERSION?m=text' | head -n 1)

if ! command -v go >/dev/null; then
    echo "Go not installed - update needed"
    update_needed=1
else
    current_ver=$(go version | cut -d' ' -f3)
    if [[ "$current_ver" != "$latest_ver" ]]; then
        echo "Go current version is $current_ver but latest version is $latest_ver - update needed"
        update_needed=1
    fi
fi

if [[ "$update_needed" == 1 ]]; then
    sudo rm -rf /usr/local/go
    curl -sS -L "https://go.dev/dl/$latest_ver.linux-amd64.tar.gz" -o /tmp/go.tar.gz
    sudo tar -C /usr/local -xzf /tmp/go.tar.gz
fi

echo "Go installed and up to date!"
