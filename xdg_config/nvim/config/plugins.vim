call plug#begin(stdpath('data') . '/plugged')

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

call plug#end()

" ----------------------------------------------------------------------------
" lotabout/skim
" ----------------------------------------------------------------------------
nnoremap <leader>f :Files .<CR>
nnoremap <leader>gf :GFiles <CR>
nnoremap <leader>B :Buffers<CR>
tnoremap <leader>f <C-\><C-n>:Files .<CR>
tnoremap <leader>B <C-\><C-n>:Buffers<CR>
