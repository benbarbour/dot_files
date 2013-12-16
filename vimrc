" MISC INIT
set nocompatible                                " Disable vi-compatibility


" NEOBUNDLE
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"" My Bundles
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/neocomplete.vim.git'
"NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
NeoBundle 'bling/vim-airline'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'klen/python-mode'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'myusuf3/numbers.vim'
NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'nvie/vim-flake8'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'rking/ag.vim'
NeoBundle 'sjbach/lusty'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'scrooloose/syntastic'
"" Case-matching substitution, abbreviation, and coercion
NeoBundle 'tpope/vim-abolish'
"" Press ga on a character to view its encodings
NeoBundle 'tpope/vim-characterize'
NeoBundle 'tpope/vim-commentary'
"" Git support
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-sleuth'
"" Use increment/decrement on dates and times
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-surround'
"" Tmux integration (:Tput :Tyank, etc)
NeoBundle 'tpope/vim-tbone'
NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'vim-scripts/bufkill.vim'
"" Golang related
NeoBundle 'Peregrinati/vim-golang'
NeoBundle 'dgryski/vim-godef'
NeoBundle 'Blackrush/vim-gocode'


"" Colorschemes
NeoBundle 'altercation/vim-colors-solarized.git'
NeoBundle 'nelstrom/vim-mac-classic-theme.git'
NeoBundle 'nelstrom/vim-blackboard.git'
NeoBundle 'vim-scripts/peaksea'
NeoBundle 'Lokaltog/vim-distinguished'

"" Bundle mappings
nmap <F2> :NumbersToggle<CR>
nmap <F3> :GundoToggle<CR>
nmap <F4> :TagbarToggle<CR>

"" Python Mode config
" Disable rope plugin
let g:pymode_rope = 0
let g:pymode_lint_ignore=""
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_rope_vim_completion = 0
let g:pymode_rope_extended_complete = 0

"" Airline settings
let g:airline_powerline_fonts = 1
"
"" Lua settings
augroup my-lua
    autocmd!
    autocmd Filetype lua setlocal list
    autocmd Filetype lua setlocal listchars=tab:>-
    autocmd Filetype lua setlocal expandtab
    autocmd Filetype lua setlocal tabstop=4
    autocmd Filetype lua setlocal shiftwidth=4
augroup end

"" Python settings
augroup my-python
    autocmd!
    autocmd Filetype python setlocal list
    autocmd Filetype python setlocal listchars=tab:>-
    autocmd Filetype python setlocal textwidth=80
    autocmd Filetype python setlocal colorcolumn=+0
    autocmd Filetype python highlight ColorColumn ctermbg=1
    autocmd Filetype python noremap <buffer> <F7> :PyLintAuto<CR>
    autocmd Filetype python noremap <buffer> <F8> :PyLintWindowToggle<CR>
augroup end

"" Markdown settings
augroup my-markdown
  autocmd!
  autocmd Filetype markdown set wrap
  autocmd Filetype markdown set linebreak
  autocmd Filetype markdown set nolist
  autocmd Filetype markdown set textwidth=0
  autocmd Filetype markdown set wrapmargin=0
augroup end

"" Go settings
let g:go_fmt_cmd = 'goimports'
augroup my-golang
  autocmd!
  autocmd FileType go set tabstop=3
  autocmd Filetype go noremap <buffer> <F7> :Fmt<CR>
  "" Fmt on save
  autocmd FileType go au BufWritePre <buffer> Fmt
  "" For commentary plugin
  autocmd FileType go set commentstring=//\ %s
augroup end

"" XML settings
augroup my-xml
    autocmd!
    let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax
augroup end

"" CTRLP config
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$|\.o|\.pyc,tags'
  \ }


" MY CONFIG

"" Colors
set t_Co=256
set background=dark
silent! colorscheme distinguished

"" Misc
let mapleader = ","                             " setting leader to ,
set tabstop=4                                   " tabs are 4 spaces
set backspace=indent,eol,start                  " backspace through everything in insert mode
set confirm                                     " confirm saves, if needed
set mouse=a                                     " use the mouse
set nowrap                                      " don't wrap lines
set textwidth=0                                 " don't wrap lines
set wrapmargin=0                                " disable line wrapping
set hidden                                      " allow hidden buffers. Required by LustyJuggler
set matchpairs+=<:>                             " Match angle brackets
" give these suffixes lower priority when opening files
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc
" ignore these filetypes in menus
set wildignore=*.o,*.png,*.jpg,*.zip,*.tar*,*.pyc,*.min.js
set nostartofline                               " Don't jump to the start of the line when switching buffers

"" Searching
set nohlsearch                                  " don't highlight matches
set incsearch                                   " incremental searching
set ignorecase                                  " searches are case insensitive...
set smartcase                                   " ... unless they contain at least one capital letter
set number                                      " enabled line numbers by default

"" Folding
set foldlevelstart=99				            "Don't fold anything when opening a new file

"" Highlight whitespace
highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/

"" Backup and undo settings
set backupdir=~/.vim/backup//                   "location of backups
set directory=~/.vim/swp//                      "location of swap files
set undofile
set undodir=~/.vim/undo//
set undolevels=9000                             "maximum number of changes that can be undone
set undoreload=9000                             "maximum number lines to save for undo on a buffer reload

"" Mappings

"-edit/source vimrc quickly
nmap <leader>ev :vsplit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>
"-strip trailing whitespace
nmap <F12> :call <SID>StripTrailingWhitespaces()<CR>
"-change working directory to current file
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
"-tab shortcuts
nnoremap tt :tabnew 
nnoremap td :tabdo 
"-don't delete a single char to a register
nnoremap x "_x
"-use Esc-d (which maps to Alt-d AND META-d in gnome-terminal) to drop to null register
nnoremap <Esc>d "_d
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

"" Functions

"-Open all changed files (as reported by git)
function! GitEditDirty()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "edit " . filename
  endfor
endfunction
command! GitEditDirty :call GitEditDirty()

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

"" Neocomplete settings
source ~/.vim/completion.vim

"" Generate ctags on save (at least for git repos)
autocmd BufWritePost *
      \ if exists('b:git_dir') && executable(b:git_dir.'/hooks/ctags') |
      \   call system('"'.b:git_dir.'/hooks/ctags" &') |
      \ endif
