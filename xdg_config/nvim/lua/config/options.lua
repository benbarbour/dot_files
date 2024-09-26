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
