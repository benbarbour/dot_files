-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- show these special characters as these symbols
vim.opt.list = true
vim.opt.listchars = {
  extends = "…",
  nbsp = "␣",
  precedes = "…",
  tab = "↦ ",
  trail = "·",
}

-- disable animations
vim.g.snacks_animate = false

-- always show diagnostic source
vim.diagnostic.config({
  float = { source = "always" },
})

vim.g.lazyvim_python_lsp = "basedpyright"

-- Enables project-local configuration. Nvim will execute any .nvim.lua,
-- .nvimrc, or .exrc file found in the current-directory and all parent
-- directories (ordered upwards), if the files are in the trust list.
-- Use :trust to manage trusted files.
vim.opt.exrc = true
