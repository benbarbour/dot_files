setlocal nolist
setlocal noexpandtab ts=2 sw=2 sts=2
setlocal textwidth=89 colorcolumn=+1

autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
