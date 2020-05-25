set autowrite                " Automatically save before :next, :make etc.
set completeopt=menu,menuone " Autocompletion using pop up menu
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set foldlevelstart=99        " Open new buffers with all folds open
set hidden                   " Allow hidden buffers
set incsearch                " Highlight search as you type
set lazyredraw               " Wait to redraw
set matchpairs+=<:>          " Match angle brackets
set nobackup                 " Don't create annoying backup files
set nocursorcolumn           " Don't highlight cursor column
set nocursorline             " Don't highlight cursor line
set noerrorbells             " No beeps
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set noswapfile               " Don't use swapfile
set nowrap                   " No soft wrapping
set number                   " Show line numbers
set pumheight=10             " Completion window max size
set relativenumber           " Show relative line numbers
set showcmd                  " Show me what I'm typing
set splitbelow               " Split horizontal windows below to the current windows
set splitright               " Split vertical windows right to the current windows

set list                     " show special characters as defined in listchars
set listchars=tab:↦\ ,extends:…,precedes:…,nbsp:¤

set ignorecase               " Search case insensitive...
set smartcase                " ... but not if it begins with upper case

let loaded_netrw = 0         " disable netrw

execute "set backupdir=" . stdpath('data') . "/backup/"

if has('persistent_undo')
  set undofile
  set undolevels=9000  " maximum number of changes that can be undone
  set undoreload=9000  " maximum number lines to save for undo on a buffer reload
endif

if has('!nvim')
  syntax enable
  set t_Co=256
endif

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

if has('nvim')
  " turn off line numbering in terminal windows
  autocmd BufWinEnter,WinEnter term://* setlocal nonumber
  autocmd BufWinEnter,WinEnter term://* setlocal norelativenumber
  autocmd BufWinEnter,WinEnter term://* setlocal signcolumn=no
  autocmd BufWinEnter,WinEnter term://* setlocal foldcolumn=1
endif

" vim: ts=2 sw=2 et
