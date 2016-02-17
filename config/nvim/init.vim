" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-abolish'       " Case-matching substitution, abbreviation, and coercion
Plug 'tpope/vim-characterize'  " Press ga on a character to view encodings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'   " Use increment/decrement on dates and times
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'
Plug 'tpope/vim-unimpaired'
nnoremap <silent> ]g :tabnext<CR>
nnoremap <silent> [g :tabprev<CR>

Plug 'benekastah/neomake'
let g:neomake_python_enabled_makers = ['pylint']
" let g:neomake_python_pylint_args = ['--rcfile=~/.pylintrc']

Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0
let g:lua_define_completion_mappings = 0

Plug 'Shougo/deoplete.nvim'
let g:deoplete#enable_at_startup = 1
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"   return deoplete#mappings#close_popup() . "\<CR>"
" endfunction
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'
Plug 'zchee/deoplete-go'
Plug 'zchee/deoplete-jedi'

Plug 'myusuf3/numbers.vim'
nmap <F2> :NumbersToggle<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
nnoremap <leader>f :Files .<CR>
nnoremap <leader>b :Buffers<CR>
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

Plug 'cespare/vim-toml'

Plug 'fisadev/vim-isort'
let g:vim_isort_map = ''

Plug 'godlygeek/tabular'
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a, :Tabularize /,\zs<CR>
  vmap <Leader>a, :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

Plug 'simnalamburt/vim-mundo'
nmap <F3> :MundoToggle<CR>

Plug 'vim-scripts/bufkill.vim'

Plug 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>

Plug 'vim-utils/vim-man'

Plug 'mhinz/vim-grepper'
let g:grepper        = {}
let g:grepper.tools  = ['git', 'ag', 'pt', 'grep']
let g:grepper.open   = 1
let g:grepper.jump   = 0
let g:grepper.switch = 1
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nnoremap <leader>/ :Grepper -nojump<CR>

Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_fmt_experimental = 1
let g:go_def_mapping_enabled = 0

Plug 'itchyny/lightline.vim'
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive' ],
    \             [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ] ],
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
\ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFilePath()
  if expand('%:p:h') =~ getcwd()
    return expand('%:f')
  else
    return expand('%:t')
  end
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != LightLineFilePath() ? fnamemodify(LightLineFilePath(), ':~:.') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

Plug 'frankier/neovim-colors-solarized-truecolor-only'

call plug#end()

" Colors and Theme
set background=dark
colorscheme solarized
highlight SpecialKey term=standout ctermfg=LightMagenta ctermbg=DarkMagenta
highlight ColorColumn ctermbg=DarkBlue

" Misc Settings
set completeopt+=noinsert
set completeopt-=longest
set completeopt-=preview
set expandtab                                   " don't use tab characters
set hidden                                      " allow hidden buffers
set list                                        " show special characters as defined in listchars
set listchars=tab:↦\ ,trail:·,extends:…,precedes:…,nbsp:¤
set matchpairs+=<:>                             " Match angle brackets
set nowrap                                      " don't wrap lines
set number                                      " show line numbers
set mouse=                                      " disable the mouse
set tabstop=4                                   " tabs are 4 spaces
set textwidth=0                                 " don't wrap lines
set wrapmargin=0                                " disable line wrapping
set laststatus=2                                " two line status setting
set nostartofline                               " don't jump to the start of the line when switching buffers
set foldlevelstart=99                           " don't fold anything when opening a new file
" give these suffixes lower priority when opening files
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.class
" ignore these filetypes in menus
set wildignore=*.o,*.png,*.jpg,*.zip,*.tar*,*.pyc,*.min.js
" hide the tabline unless there's multiple tabs
set showtabline=1

" try and speed vim up
" let loaded_matchparen=1 " Don't load matchit.vim (paren/bracket matching)
" set noshowmatch         " Don't match parentheses/brackets
" set nocursorline        " Don't paint cursor line
" set nocursorcolumn      " Don't paint cursor column
" set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=1 " Don't render italic, bold, links in HTML

" Searching
set nohlsearch                                  " don't highlight matches
set incsearch                                   " incremental searching
set ignorecase                                  " searches are case insensitive...
set smartcase                                   " ... unless they contain at least one capital letter
set smartindent                                 " Do smart indenting at the start of a new line

" Backup and undo settings
set backupdir=~/.config/nvim/backup//           " location of backups
set directory=~/.config/nvim/swp//              " location of swap files
set undofile
set undodir=~/.config/nvim/undo//
set undolevels=900                              " maximum number of changes that can be undone
set undoreload=900                              " maximum number lines to save for undo on a buffer reload

" Mappings
let mapleader = ","                             " setting leader to ','
nmap <leader>ev :vsplit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>
" Use ALT-d to drop to null register
nmap <A-d> "_d
"-X drops to null register
nnoremap x "_x
"-strip trailing whitespace
nmap <F12> :call <SID>StripTrailingWhitespaces()<CR>
"-change working directory to current file's directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
"-Map <C-Up> to 'prev quickfix entry'
noremap [A :cp<cr>
"-Map <C-Down> to 'next quickfix entry'
noremap [B :cn<cr>
"-Map <C-I> to 'Increment number'
noremap <C-I> <C-A>
"-Map <C-D> to 'Decrement number'
noremap <C-D> <C-X>
"-Disable Ex-mode (I never use it and it's easy to get stuck in)
map Q <Nop>
"-Jump to first item in location list
nnoremap <leader>ll :ll 1<CR>
"-tab shortcuts
nnoremap tt :tabnew 
nnoremap td :tabdo 

" Terminal Settings
:tnoremap <Esc> <C-\><C-n>
:tnoremap <C-w> <C-\><C-n><C-w>
augroup my-terminal
  autocmd!
  autocmd TermOpen * setlocal nolist
augroup end

" Spell checking
hi clear SpellBad
hi SpellBad cterm=undercurl
hi SpellCap cterm=NONE ctermbg=NONE
hi SpellLocal cterm=NONE
hi SpellRare cterm=NONE

" Shows hilight markers on selected character
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Functions

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction


" FILETYPE SPECIFIC SETTINGS

"" Go settings
au BufRead,BufNewFile *.go set filetype=go
augroup my-golang
  autocmd!
  autocmd Filetype go setlocal nolist
  autocmd Filetype go setlocal textwidth=90
  autocmd Filetype go setlocal colorcolumn=+1
  autocmd Filetype go setlocal tabstop=2
  autocmd Filetype go setlocal shiftwidth=2
  autocmd FileType go setlocal spell
  " vim-go settings
  autocmd Filetype go nmap <Leader>gi <Plug>(go-info)
  autocmd Filetype go nmap <Leader>gg <Plug>(go-generate)
  autocmd Filetype go nmap <Leader>gt <Plug>(go-test)
  autocmd Filetype go nmap <Leader>gC <Plug>(go-coverage)
  autocmd Filetype go nmap <Leader>gb <Plug>(go-build)
  autocmd Filetype go nmap <Leader>gB <Plug>(go-doc-browser)
  autocmd Filetype go nmap <Leader>gd <Plug>(go-def)
  autocmd Filetype go nmap <Leader>gD <Plug>(go-def-split)
  autocmd Filetype go nmap <Leader>gr <Plug>(go-rename)
  autocmd Filetype go nmap <Leader>gI <Plug>(go-implements)
augroup end

"" Markdown settings
augroup my-markdown
  autocmd!
  autocmd Filetype markdown setlocal wrap
  autocmd Filetype markdown setlocal linebreak
  autocmd Filetype markdown setlocal textwidth=0
  autocmd Filetype markdown setlocal wrapmargin=0
  autocmd Filetype markdown setlocal spell spelllang=en_us
  autocmd Filetype markdown setlocal mousemodel=popup_setpos
  autocmd Filetype markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd FileType markdown setlocal spell
augroup end

"" Python settings
augroup my-python
  autocmd!
  autocmd Filetype python setlocal expandtab
  autocmd Filetype python setlocal textwidth=79
  autocmd Filetype python setlocal colorcolumn=+1
  autocmd Filetype python setlocal tabstop=4
  autocmd Filetype python setlocal shiftwidth=4
  autocmd Filetype python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePost,BufEnter *.py Neomake
  autocmd Filetype python nmap <Leader>ac :Tabularize / #<CR>
  autocmd Filetype python vmap <Leader>ac :Tabularize / #<CR>
  autocmd FileType python setlocal spell
augroup end

"" Lua settings
augroup my-lua
  autocmd!
  autocmd Filetype lua setlocal textwidth=79
  autocmd Filetype lua setlocal colorcolumn=+1
  autocmd Filetype lua setlocal expandtab
  autocmd Filetype lua setlocal tabstop=4
  autocmd Filetype lua setlocal shiftwidth=4
  autocmd FileType lua autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd FileType lua nmap <Leader>ac :Tabularize /--<CR>
  autocmd FileType lua vmap <Leader>ac :Tabularize /--<CR>
  autocmd FileType lua setlocal spell
augroup end
