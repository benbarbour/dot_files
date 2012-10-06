set rtp+=/opt/google/go/misc/vim

set grepprg=grep\ -nH\ %$*
set nocompatible                "Forget about acting like vi
set autoindent                  "Set indent to previous indent
set smartindent                 "Guess indent based language
set tabstop=4                   "4 space tabstops
set shiftwidth=4                "4 space indents
set expandtab                   "Don't use tabs
set showmatch                   "match brace, brackets, etc
set vb t_fb=                    "Stop beeps, flash screen instead
set ruler                       "Status line with cursor position
set incsearch                   "Set incremental search
set showtabline=2               "Always show the tab line
set backspace=indent,eol,start  "make the backspace key more flexible
set backup                      "make backup files
set backupdir=~/.vim/backup//   "location of backups
set directory=~/.vim/tmp//      "location of swap files
set dir=~/.vim/tmp//            "location of swap files
set fileformats=unix,dos,mac    "support all 3, in that order
set iskeyword+=_,$,@,%,#        "none of these are word dividers
set mouse=a                     "use the mouse
"set cursorcolumn                "highlight the current column
set cursorline                  "highlight the current line
set number                      "show line numbers
set numberwidth=3               "show up to line 999 by default
set background=dark             "use colors that look good on a dark background
set wildmenu                    "better command line completion
set showcmd                     "show partial commands in the last line of the screen
set noexrc                      "don't use exrc files
"set hidden                      "Allows switching from unsaved buffers
set nostartofline               "stop certain movements from always going to the start of the line
set laststatus=2                "always show the status line
set statusline=%f\ \ \ \ \ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]
set confirm                     "confirm saves, if needed
set cmdheight=2                 "set the command window height to 2 lines
let g:tex_flavor='latex'        "Make .tex files open with vim-latex
set nowrap                      "Don't wrap lines by default

set undodir=~/.vim/undodir//
set undofile
set undolevels=1000             "maximum number of changes that can be undone
set undoreload=10000            "maximum number lines to save for undo on a buffer reload

filetype plugin indent on       "load filetype specific plugins/indent settings
syntax on                       "enable syntax highlighting

"hilight comments in gray
hi Comment ctermfg=gray

"Change visual mode highlight color
hi Visual gui=bold ctermfg=black ctermbg=lightgreen

"map ALT-d, META-d, and <Esc>d to 'cut to the null buffer'
map <Esc>d "_d

"tab movement commands
nmap tt  :tabnew
"nmap tn  :tabnext<CR>
"nmap tp  :tabprevious<CR>
vnoremap _( <Esc>`>a)<Esc>`<i(<Esc>

"highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Show  tab characters. Visual Whitespace.
set list
set listchars=tab:>-

"remove trailing whitespace
augroup whitespace
    autocmd!
    autocmd BufWritePre *.php :%s/\s\+$//e
    autocmd BufWritePre *.cpp :%s/\s\+$//e
    autocmd BufWritePre *.c++ :%s/\s\+$//e
    autocmd BufWritePre *.h :%s/\s\+$//e
    autocmd BufWritePre *.java :%s/\s\+$//e
    autocmd BufWritePre *.go :%s/\s\+$//e
    autocmd BufWritePre *.py :%s/\s\+$//e
    autocmd BufWritePre .vimrc :%s/\s\+$//e
augroup END

"Omnicompletion tweaks
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
set completeopt=menu",longest
highlight Pmenu gui=bold ctermbg=black ctermfg=lightblue
highlight PmenuSel gui=bold ctermbg=black ctermfg=lightcyan
