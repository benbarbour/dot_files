vim.opt.autowrite      = true                    -- automatically save when switching buffers
vim.opt.fileformats    = {'unix', 'dos', 'mac'}  -- prefer unix over Windows over OS9 formats on all platforms
vim.opt.matchpairs:append{'<:>'}                 -- match angle brackets
vim.opt.showmode       = false                   -- don't print the mode on the screen (let a statusline show that)
vim.opt.swapfile       = false                   -- don't use swapfile; undofile seems good enough
vim.opt.wrap           = false                   -- don't soft wrap
vim.opt.number         = true                    -- print the number of each line on the left
vim.opt.relativenumber = true                    -- use relative line numbering
vim.opt.splitbelow     = true                    -- split horizontally below the current window
vim.opt.splitright     = true                    -- split vertically to the right of the current window

-- show these special characters as these symbols
vim.opt.list      = true
vim.opt.listchars = {
    extends  = '…',
    nbsp     = '␣',
    precedes = '…',
    tab      = '↦ ',
    trail    = '·',
}

-- make search text case insensitive unless it contains an upper case character
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- persist undofiles, all in a common folder
vim.opt.undofile       = true
vim.opt.undolevels     = 9999  -- maximum amount of changes that can be undone
vim.opt.undoreload     = 9999  -- save the whole buffer (up to this many lines) for undo when reloading it

-- open help vertically and on the far right (TODO: Change to lua with neovim 0.7.0)
vim.cmd('command! -nargs=* -complete=help Help vertical belowright help <args>')
vim.cmd('autocmd FileType help wincmd L')

-- turn off line numbering in terminal windows (TODO: Change to lua with neovim 0.7.0)
vim.cmd('autocmd BufWinEnter,WinEnter term://* setlocal nonumber')
vim.cmd('autocmd BufWinEnter,WinEnter term://* setlocal norelativenumber')
vim.cmd('autocmd BufWinEnter,WinEnter term://* setlocal signcolumn=no')
vim.cmd('autocmd BufWinEnter,WinEnter term://* setlocal foldcolumn=0')
vim.cmd('autocmd BufWinEnter,WinEnter term://* setlocal nolist')

-- vim: expandtab ts=4 sw=4
