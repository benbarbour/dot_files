-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<A-d>", '"_d', { desc = "Delete to null register" })
map("n", "x", '"_x', { desc = "Delete to null register", remap = false })
map("n", "X", '"_x', { desc = "Delete to null register", remap = false })
