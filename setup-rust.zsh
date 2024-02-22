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

cargo install \
    bat \
    exa \
    fd-find \
    grex \
    procs \
    ripgrep \
    sd \
    skim \
    starship \
    tokei \
    tree-sitter-cli \
    watchexec-cli \
    ytop \
    ;
