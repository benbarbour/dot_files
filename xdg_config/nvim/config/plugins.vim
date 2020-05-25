call plug#begin(stdpath('data') . '/plugged')

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-unimpaired'

call plug#end()

" ----------------------------------------------------------------------------
" lotabout/skim
" ----------------------------------------------------------------------------
nnoremap <leader>f :Files .<CR>
nnoremap <leader>gf :GFiles <CR>
nnoremap <leader>B :Buffers<CR>
tnoremap <leader>f <C-\><C-n>:Files .<CR>
tnoremap <leader>B <C-\><C-n>:Buffers<CR>

" ----------------------------------------------------------------------------
" ntpeters/vim-better-whitespace
" ----------------------------------------------------------------------------
nmap <F12> :StripWhitespace<CR>
