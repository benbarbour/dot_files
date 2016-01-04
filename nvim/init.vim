" Plugins
call plug#begin('~/.nvim/plugged')

Plug 'tpope/vim-abolish'       " Case-matching substitution, abbreviation, and coercion
Plug 'tpope/vim-characterize'  " Press ga on a character to view encodings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-flagship'
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

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

Plug 'myusuf3/numbers.vim'
nmap <F2> :NumbersToggle<CR>

Plug 'Lokaltog/vim-distinguished'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Disable tab (let ultisnips use it!)
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
nnoremap <leader>d :YcmCompleter GoTo<CR>
nnoremap K :YcmCompleter GetDoc<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
nnoremap <leader>f :Files .<CR>
nnoremap <leader>b :Buffers<CR>

Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
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

Plug 'Lokaltog/vim-easymotion'

Plug 'simnalamburt/vim-mundo'
nmap <F3> :GundoToggle<CR>

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
nnoremap <leader>/ :Grepper!<CR>

Plug 'fatih/vim-go'

call plug#end()

" Colors
set t_Co=256
set background=dark
silent! colorscheme distinguished
highlight SpecialKey term=standout ctermfg=LightMagenta ctermbg=DarkMagenta
highlight ColorColumn ctermbg=233

" Misc Settings
set expandtab                                   " don't use tab characters
set hidden                                      " allow hidden buffers
set list                                        " show special characters as defined in listchars
set listchars=tab:↦\ ,trail:·,extends:…,precedes:…,nbsp:¤
set matchpairs+=<:>                             " Match angle brackets
set nowrap                                      " don't wrap lines
set number                                      " show line numbers
set mouse=a                                     " enable the mouse
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
  autocmd Filetype go setlocal textwidth=100
  autocmd Filetype go setlocal tabstop=2
  autocmd Filetype go setlocal shiftwidth=2
  autocmd Filetype go setlocal completeopt-=preview
  " vim-go settings
  let g:go_fmt_command = "goimports"
  let g:go_fmt_experimental = 1
  let g:go_def_mapping_enabled = 0
  autocmd Filetype go nmap <Leader>gi <Plug>(go-info)
  autocmd Filetype go nmap <Leader>gg <Plug>(go-generate)
  autocmd Filetype go nmap <Leader>gt <Plug>(go-test)
  autocmd Filetype go nmap <Leader>gc <Plug>(go-coverage)
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
  autocmd Filetype python setlocal completeopt=menuone,longest
  autocmd Filetype python nmap <Leader>ac :Tabularize / #<CR>
  autocmd Filetype python vmap <Leader>ac :Tabularize / #<CR>
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
augroup end

" WORK ONLY
nnoremap <leader>u :silent !copyvm -n -s bbs<CR><C-l>
nnoremap <leader>U :silent !copyvm -n -s bbs2<CR><C-l>
