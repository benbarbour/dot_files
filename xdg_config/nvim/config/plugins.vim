call plug#begin(stdpath('data') . '/plugged')

Plug 'iCyMind/NeoSolarized'
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'
Plug 'mhinz/vim-grepper'
Plug 'mhinz/vim-signify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pangloss/vim-javascript'
Plug 'rbong/vim-crystalline'
Plug 'rhysd/git-messenger.vim'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" LSP and autocompletion plugins
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'

call plug#end()

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
let g:signify_priority = 5

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

" ----------------------------------------------------------------------------
" prabirshrestha/vim-lsp | mattn/vim-lsp-settings
" ----------------------------------------------------------------------------
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nmap <buffer> A <plug>(lsp-code-action)
    nmap <buffer> F <plug>(lsp-document-format)
    vmap <buffer> F <plug>(lsp-document-range-format)

    autocmd BufWritePre <buffer> LspDocumentFormatSync
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_documentation_float = 0
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_hint = {'text': '☛'}
let g:lsp_signs_information = {'text': '➤'}
let g:lsp_signs_priority = 11
let g:lsp_signs_warning = {'text': '⚠'}
let g:lsp_virtual_text_enabled = 0

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" ----------------------------------------------------------------------------
" prabirshrestha/asyncomplete.vim
" ----------------------------------------------------------------------------
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
