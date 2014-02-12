" MISC INIT
set nocompatible                                " Disable vi-compatibility

" PLUGINS / NEOBUNDLE
if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
 \ 'build' : {
 \     'windows' : 'make -f make_mingw32.mak',
 \     'cygwin' : 'make -f make_cygwin.mak',
 \     'mac' : 'make -f make_mac.mak',
 \     'unix' : 'make -f make_unix.mak',
 \    },
 \ }
filetype plugin indent on     " Required!

"" My Bundles
NeoBundle 'Shougo/neocomplete.vim.git'
source ~/.vim/completion.vim

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

NeoBundle 'Shougo/unite.vim'

NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1

NeoBundle 'blackrush/vim-gocode'

NeoBundle 'davidhalter/jedi-vim'
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0

NeoBundle 'godlygeek/tabular'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>

NeoBundle 'myusuf3/numbers.vim'
nmap <F2> :NumbersToggle<CR>

NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'rking/ag.vim'
NeoBundle 'sjl/gundo.vim'
nmap <F3> :GundoToggle<CR>

NeoBundle 'scrooloose/syntastic'
let g:syntastic_python_checkers = ['flake8', 'pylint']
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2
let g:syntastic_loc_list_height = 5
let g:syntastic_python_flake8_args="--ignore=E501"
"   E501: Line too long
let g:syntastic_error_symbol="✗"
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list=1
noremap <silent><leader>lc :lcl<CR>

NeoBundle 'tpope/vim-abolish'       " Case-matching substitution, abbreviation, and coercion
NeoBundle 'tpope/vim-characterize'  " Press ga on a character to view encodings
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-speeddating'   " Use increment/decrement on dates and times
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'         " Tmux integration (:Tput :Tyank, etc)
NeoBundle 'tpope/vim-unimpaired'
nnoremap <silent> ]g :tabnext<CR>
nnoremap <silent> [g :tabprev<CR>

NeoBundle 'tsaleh/vim-matchit'
NeoBundle 'vim-scripts/bufkill.vim'

"" Colorschemes
NeoBundle 'Lokaltog/vim-distinguished'

" MY CONFIG

"" Colors
set t_Co=256
set background=dark
silent! colorscheme distinguished

"" Markdown settings
augroup my-markdown
  autocmd!
  autocmd Filetype markdown set wrap
  autocmd Filetype markdown set linebreak
  autocmd Filetype markdown set nolist
  autocmd Filetype markdown set textwidth=0
  autocmd Filetype markdown set wrapmargin=0
augroup end

"" Python settings
augroup my-python
    autocmd!
    autocmd Filetype python setlocal list
    autocmd Filetype python setlocal listchars=tab:>-
    autocmd Filetype python setlocal textwidth=80
    autocmd Filetype python setlocal colorcolumn=80
    autocmd Filetype python highlight ColorColumn ctermbg=232
    autocmd Filetype python setlocal tabstop=4
    autocmd Filetype python setlocal shiftwidth=4
    autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

"" Lua settings
augroup my-lua
    autocmd!
    autocmd Filetype lua setlocal list
    autocmd Filetype lua setlocal listchars=tab:>-
    autocmd Filetype lua setlocal textwidth=79
    autocmd Filetype lua setlocal colorcolumn=+1
    autocmd Filetype lua highlight ColorColumn ctermbg=68
    autocmd Filetype lua setlocal expandtab
    autocmd Filetype lua setlocal tabstop=4
    autocmd Filetype lua setlocal shiftwidth=4
    autocmd FileType lua autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

"" Go settings
filetype off
filetype plugin indent off
let govim=system('go env GOROOT')
let govim=substitute(govim, '\n$', '', '').'/misc/vim'
let &runtimepath.=','.govim
filetype plugin indent on
syntax on
let g:gofmt_command="goimports"
autocmd FileType go autocmd BufWritePre <buffer> Fmt

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
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.class
" ignore these filetypes in menus
set wildignore=*.o,*.png,*.jpg,*.zip,*.tar*,*.pyc,*.min.js
set nostartofline                               " Don't jump to the start of the line when switching buffers
set splitbelow                                  " Open splits, including preview windows, etc, on the bottom

"" Searching
set nohlsearch                                  " don't highlight matches
set incsearch                                   " incremental searching
set ignorecase                                  " searches are case insensitive...
set smartcase                                   " ... unless they contain at least one capital letter
set number                                      " enabled line numbers by default

"" Folding
set foldlevelstart=99				            "Don't fold anything when opening a new file

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
"-change working directory to current file's directory
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
"-Jump to first item in location list
nnoremap <leader>ll :ll 1<CR>

"" FUNCTIONS

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

"" Generate ctags on save (at least for git repos)
autocmd BufWritePost *
      \ if exists('b:git_dir') && executable(b:git_dir.'/hooks/ctags') |
      \   call system('"'.b:git_dir.'/hooks/ctags" &') |
      \ endif

"" Unite settings
let g:unite_source_history_yank_enable = 1
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_rec_max_cache_files=5000
let g:unite_enable_start_insert = 1
let g:unite_split_rule = "botright"
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 10
let g:unite_source_grep_command = 'ag'

call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ '\.pyc',
      \ ], '\|'))

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <leader>/ :Unite -no-split grep:.<cr>
nnoremap <leader>y :Unite -no-split -start-insert history/yank<cr>
nnoremap <leader>f :Unite -no-split -start-insert file_rec/async<cr>
nnoremap <leader>b :Unite -no-split buffer<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

"" Highlight trailing whitespace
highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/
