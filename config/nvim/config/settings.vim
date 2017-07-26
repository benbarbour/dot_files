" I'm still using Vim from time to time. These needs to enabled so we can make
" Vim usable again (these are default on NeoVim)

if !has('nvim')
  set nocompatible
  filetype off
  filetype plugin indent on

  set ttyfast
  set ttymouse=xterm2
  set ttyscroll=3

  set laststatus=2
  set encoding=utf-8              " Set default encoding to UTF-8
  set autoread                    " Automatically reread changed files without asking me anything
  set autoindent
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set incsearch                   " Shows the match while typing
  set hlsearch                    " Highlight found searches
  set mouse=a
endif

if has('nvim')
  set termguicolors
  au VimLeave * set guicursor=a:block-blinkoff150-blinkon175
  let g:terminal_scrollback_buffer_size = 100000
endif

set autowrite                " Automatically save before :next, :make etc.
set completeopt=menu,menuone " Autocompletion using pop up menu
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set hidden                   " Allow hidden buffers
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
set relativenumber           " Show relative line numbers
set pumheight=10             " Completion window max size
set showcmd                  " Show me what I'm typing
set splitbelow               " Split horizontal windows below to the current windows
set splitright               " Split vertical windows right to the current windows

set list                     " show special characters as defined in listchars
set listchars=tab:↦\ ,trail:·,extends:…,precedes:…,nbsp:¤

set ignorecase               " Search case insensitive...
set smartcase                " ... but not if it begins with upper case

if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/undo//
  set undolevels=900  " maximum number of changes that can be undone
  set undoreload=900  " maximum number lines to save for undo on a buffer reload
endif

if has('!nvim')
  syntax enable
  set t_Co=256
endif

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" vim: ts=2 sw=2 et
