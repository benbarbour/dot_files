vim.g.mapleader = ','

-- Let me delete to the null register with ALT
vim.api.nvim_set_keymap('n', '<A-d>', '"_d', {})

-- Don't copy single characters to the default register
vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true })
vim.api.nvim_set_keymap('n', 'X', '"_X', { noremap = true })

-- Increment and Decrement numbers
vim.api.nvim_set_keymap('n', '<C-I>', '<C-A>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-D>', '<C-X>', { noremap = true })

-- Make CTRL-W mappings work in terminal mode
vim.api.nvim_set_keymap('t', '<C-w>', '<C-\\><C-n><C-w>', { noremap = true })

-- Return to insert mode from terminal mode
vim.api.nvim_set_keymap('t', '<leader><A-q>', '<C-\\><C-n>', { noremap = true })

-- Open terminal in splits or current window
vim.api.nvim_set_keymap('n', '<leader>Tb', ':e term://zsh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('t', '<leader>Tb', '<C-\\><C-n>:e term://zsh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Tv', ':vsplit term://zsh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('t', '<leader>Tv', '<C-\\><C-n>:vsplit term://zsh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Ts', ':split term://zsh<CR>i', { noremap = true })
vim.api.nvim_set_keymap('t', '<leader>Ts', '<C-\\><C-n>:split term://zsh<CR>i', { noremap = true })

-- vim-unimpaired mappings in terminal mode
vim.api.nvim_set_keymap('t', '[b', '<C-\\><C-n>:bprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', ']b', '<C-\\><C-n>:bnext<CR>', { noremap = true })

-- Clear current search highlight
vim.api.nvim_set_keymap('', '<F3>', ':noh<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-space>', '<c-x><c-o>', { noremap = true, silent = true })
