header "SETUP RUST"

cargo install \
    exa \
    fd-find \
    grex \
    procs \
    ripgrep \
    sd \
    skim \
    tokei \
    tree-sitter-cli \
    ;

curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin

