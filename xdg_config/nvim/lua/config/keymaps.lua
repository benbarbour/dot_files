-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local unmap = vim.keymap.del

local wk = require("which-key")

map("n", "<A-d>", '"_d', { desc = "Delete to null register" })
map("n", "x", '"_x', { desc = "Delete to null register", remap = false })
map("n", "X", '"_x', { desc = "Delete to null register", remap = false })

-- Set new terminal mappings
map("t", "<C-w>", [[<C-\><C-n><C-w>]])
wk.add({
  {
    mode = "n",
    { "<leader>T", group = "Terminal" },
    { "<leader>Tv", ":vsplit +terminal<CR>", desc = "Open terminal in vertical split" },
    { "<leader>Ts", ":split +terminal<CR>", desc = "Open terminal in horizontal split" },
  },
})
