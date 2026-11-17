header "SETUP RUST"

if ! command -v rustup >/dev/null; then
    curl -sS --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output /tmp/sh.rustup.rs
    chmod +x /tmp/sh.rustup.rs
    /tmp/sh.rustup.rs -y --no-modify-path
fi

if [ ! -f "$ZDOTDIR/.zfunc/_rustup" ]; then
    mkdir -p "$ZDOTDIR/.zfunc/"
    rustup completions zsh > "$ZDOTDIR/.zfunc/_rustup"
fi

rustup update

# One at a time: given several, cargo reports all but the first stale crate as up to date.
for crate in \
    bat \
    bottom \
    exa \
    fd-find \
    grex \
    procs \
    ripgrep \
    sd \
    shpool \
    skim \
    somo \
    starship \
    tokei \
    tree-sitter-cli \
    watchexec-cli \
    ; do
    cargo install "$crate"
done
