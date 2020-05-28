call plug#begin(stdpath('data') . '/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-grepper'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rbong/vim-crystalline'
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
" rbong/vim-crystalline
" ----------------------------------------------------------------------------
function! StatusLine(...)
  return crystalline#mode() . crystalline#right_mode_sep('')
        \ . ' %f%h%w%m%r ' . crystalline#right_sep('', 'Fill') . '%='
        \ . crystalline#left_sep('', 'Fill') . ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
endfunction
let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme = 'default'
set laststatus=2

" ----------------------------------------------------------------------------
" rhysd/git-messenger.vim
" ----------------------------------------------------------------------------
let g:git_messenger_no_default_mappings = v:false
command! GBlame GitMessenger
command! Gblame GitMessenger
nmap <leader>gb <Plug>(git-messenger)
