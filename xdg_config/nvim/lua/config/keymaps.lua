-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "<A-d>", '"_d', { desc = "Delete to null register" })
map("n", "x", '"_x', { desc = "Delete to null register", remap = false })
map("n", "X", '"_x', { desc = "Delete to null register", remap = false })

unmap("n", "<c-_>")
unmap("t", "<c-_>")

-- Remove default terminal mappings (see ../plugins/toggleterm.lua)
unmap("n", "<leader>ft")
unmap("n", "<leader>fT")

-- Set new terminal mappings
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
