call plug#begin(stdpath('data') . '/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'iCyMind/NeoSolarized'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'rbong/vim-crystalline'
Plug 'rhysd/git-messenger.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

" ----------------------------------------------------------------------------
" autozimu/LanguageClient-neovim
" ----------------------------------------------------------------------------
set hidden
set signcolumn=yes
let g:LanguageClient_serverCommands = {
    \ 'rust': [$CARGO_HOME.'/bin/rustup', 'run', 'stable', 'rls'],
    \ }

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType rust call SetLSPShortcuts()
augroup END

" ----------------------------------------------------------------------------
" iCyMind/NeoSolarized
" ----------------------------------------------------------------------------
set background=dark
set termguicolors
let g:neosolarized_contrast = "high"
let g:neosolarized_vertSplitBgTrans = 1
let g:neosolarized_termBoldAsBright = 1
colorscheme NeoSolarized
highlight clear SignColumn
highlight clear LineNr
highlight clear CursorLineNr
highlight clear FoldColumn

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
" mhinz/vim-signify
" ----------------------------------------------------------------------------
set updatetime=100
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd    ctermfg=22  guifg=#00ff00 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=220 guifg=#ffff00 cterm=NONE gui=NONE

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

" ----------------------------------------------------------------------------
" simnalamburt/vim-mundo
" ----------------------------------------------------------------------------
nmap <F3> :MundoToggle<CR>
