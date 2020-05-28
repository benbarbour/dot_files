call plug#begin(stdpath('data') . '/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-grepper'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

" ----------------------------------------------------------------------------
" Shougo/deoplete.nvim
" ----------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" ----------------------------------------------------------------------------
" lotabout/skim
" ----------------------------------------------------------------------------
nnoremap <leader>f :Files .<CR>
nnoremap <leader>gf :GFiles <CR>
nnoremap <leader>B :Buffers<CR>
tnoremap <leader>f <C-\><C-n>:Files .<CR>
tnoremap <leader>B <C-\><C-n>:Buffers<CR>

" ----------------------------------------------------------------------------
" mhinz/vim-grepper
" ----------------------------------------------------------------------------
let g:grepper = {}
let g:grepper.tools = ['git', 'rg']
let g:grepper.quickfix = 1
let g:grepper.dir = 'repo,cwd'

nnoremap <leader>* :Grepper -cword -noprompt<cr>
nnoremap <leader>/ :Grepper -nojump<CR>
tnoremap <leader>/ <C-\><C-n>:Grepper -nojump<CR>

" ----------------------------------------------------------------------------
" ntpeters/vim-better-whitespace
" ----------------------------------------------------------------------------
nmap <F12> :StripWhitespace<CR>

" ----------------------------------------------------------------------------
" rhysd/git-messenger.vim
" ----------------------------------------------------------------------------
let g:git_messenger_no_default_mappings = v:false
command! GBlame GitMessenger
command! Gblame GitMessenger
nmap <leader>gb <Plug>(git-messenger)
