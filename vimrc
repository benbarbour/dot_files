" MISC INIT
set nocompatible                                " Disable vi-compatibility

" PLUGINS / NEOBUNDLE
if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

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
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'

NeoBundle 'airblade/vim-gitgutter'
let g:gitgutter_realtime=0
let g:gitgutter_map_keys = 0
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterRevertHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

NeoBundle 'bling/vim-airline'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_powerline_fonts               = 0
let g:airline_left_sep                      = ''
let g:airline_left_alt_sep                  = ''
let g:airline_right_sep                     = ''
let g:airline_right_alt_sep                 = ''
let g:airline_symbols.branch                = ''
let g:airline_symbols.readonly              = ''
let g:airline_symbols.linenr                = ''
let g:airline#extensions#hunks#enabled      = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled     = 1
let g:airline#extensions#syntastic#enabled  = 0

NeoBundle 'edkolev/tmuxline.vim'

NeoBundle 'cespare/vim-toml'

NeoBundle 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_on_dot = 0

NeoBundle 'fatih/vim-go'
let g:go_snippet_engine      = "neosnippet"
let g:go_fmt_fail_silently   = 1
let g:go_def_mapping_enabled = 1

NeoBundle 'godlygeek/tabular'
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

" Auto align when entering the '|' character
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'majutsushi/tagbar'
nmap <F4> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

NeoBundle 'myusuf3/numbers.vim'
nmap <F2> :NumbersToggle<CR>

NeoBundle 'nelstrom/vim-visual-star-search'
NeoBundle 'rking/ag.vim'
NeoBundle 'sjl/gundo.vim'
nmap <F3> :GundoToggle<CR>

NeoBundle 'scrooloose/syntastic'
let g:syntastic_go_checkers = ['go', 'govet']
let g:syntastic_python_checkers = ['pep8', 'pylint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_sort_aggregated_errors = 1
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=2
let g:syntastic_loc_list_height = 5
let g:syntastic_python_pylint_post_args = '--msg-template="{path}:{line}:{column}:{C}: {msg_id}[{symbol}] {msg}"'
let g:syntastic_python_pylint_args = '--rcfile=/home/bbarbour/.pylintrc'
let g:syntastic_error_symbol="✗"
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_always_populate_loc_list=1
" E501 is line too long, which will be picked up by pylint (if set in pylint.rc)
let g:syntastic_python_pep8_post_args = '--ignore=E501'

NeoBundle 'tpope/vim-abolish'       " Case-matching substitution, abbreviation, and coercion
NeoBundle 'tpope/vim-characterize'  " Press ga on a character to view encodings
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-fugitive', { 'augroup' : 'fugitive' }
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-speeddating'   " Use increment/decrement on dates and times
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-tbone'         " Tmux integration (:Tput :Tyank, etc)
NeoBundle 'tpope/vim-unimpaired'
nnoremap <silent> ]g :tabnext<CR>
nnoremap <silent> [g :tabprev<CR>

NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/bufkill.vim'
NeoBundle 'vim-scripts/hexman.vim'

" All lazy files are sourced at the end of this one
NeoBundleLazy 'tpope/vim-sensible'

" Auto close quotes, parens, etc
NeoBundle 'raimondi/delimitMate'

"" Colorschemes
NeoBundle 'Lokaltog/vim-distinguished'

"" Tags
NeoBundle 'craigemery/vim-autotag'

" MY CONFIG

"" Colors
set t_Co=256
set background=dark
silent! colorscheme distinguished

"" Misc
set list
set listchars=tab:↦\ ,trail:·,extends:…,precedes:…,nbsp:¤
highlight SpecialKey term=standout ctermfg=LightMagenta ctermbg=DarkMagenta
highlight ColorColumn ctermbg=233
let mapleader = ","                             " setting leader to ','
set tabstop=4                                   " tabs are 4 spaces
set backspace=indent,eol,start                  " backspace through everything in insert mode
set confirm                                     " confirm saves, if needed
set mouse=a                                     " use the mouse
set nowrap                                      " don't wrap lines
set textwidth=0                                 " don't wrap lines
set wrapmargin=0                                " disable line wrapping
set hidden                                      " allow hidden buffers
set matchpairs+=<:>                             " Match angle brackets
" give these suffixes lower priority when opening files
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.class
" ignore these filetypes in menus
set wildignore=*.o,*.png,*.jpg,*.zip,*.tar*,*.pyc,*.min.js
set nostartofline                               " Don't jump to the start of the line when switching buffers
" set splitbelow                                  " Open splits, including preview windows, etc, on the bottom

"" Searching
set nohlsearch                                  " don't highlight matches
set incsearch                                   " incremental searching
set ignorecase                                  " searches are case insensitive...
set smartcase                                   " ... unless they contain at least one capital letter
set number                                      " enabled line numbers by default

"" Folding
set foldlevelstart=99                           " don't fold anything when opening a new file

"" Backup and undo settings
set backupdir=~/.vim/backup//                   " location of backups
set directory=~/.vim/swp//                      " location of swap files
set undofile
set undodir=~/.vim/undo//
set undolevels=9000                             " maximum number of changes that can be undone
set undoreload=9000                             " maximum number lines to save for undo on a buffer reload

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

"" Unite settings
let g:unite_source_history_yank_enable = 1
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_rec_max_cache_files=0
let g:unite_force_overwrite_statusline = 0
let g:unite_source_grep_command = 'ag'

call unite#custom_source('file_mru,file_rec,file_rec/async,grepocate',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'git5/.*/review/',
      \ 'google/obj/',
      \ '\.pyc',
      \ ], '\|'))

call unite#custom_source('file_mru,file_rec,file_rec/async,grepocate',
      \ 'max_candidates', 0)

" Use the fuzzy matcher for everything
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Use the rank sorter for everything
call unite#filters#sorter_default#use(['sorter_rank'])

"Like ctrlp.vim settings
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'top',
\ })

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
" nnoremap <leader>g :Unite -no-split grep<cr>

autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

" FILETYPE SPECIFIC SETTINGS

"" Go settings
au BufRead,BufNewFile *.go set filetype=go
augroup my-golang
  autocmd!
  autocmd FileType go setlocal nolist
  autocmd FileType go nmap <Leader>gi <Plug>(go-info)
  autocmd FileType go nmap <Leader>gu <Plug>(go-install)
  autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <Leader>gs <Plug>(go-def-tab)
  autocmd FileType go nmap <Leader>gr <Plug>(go-rename)
  autocmd Filetype go setlocal textwidth=100
  autocmd Filetype go setlocal tabstop=2
  autocmd Filetype go setlocal shiftwidth=2
  autocmd Filetype go setlocal completeopt-=preview
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
  autocmd FileType markdown autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

"" Python settings
augroup my-python
  autocmd!
  autocmd Filetype python setlocal expandtab
  autocmd Filetype python setlocal textwidth=79
  autocmd Filetype python setlocal colorcolumn=+1
  autocmd Filetype python setlocal tabstop=4
  autocmd Filetype python setlocal shiftwidth=4
  autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd FileType python setlocal completeopt=menuone,longest
  autocmd FileType python nmap <Leader>ac :Tabularize / #<CR>
  autocmd FileType python vmap <Leader>ac :Tabularize / #<CR>
augroup end

"" Lua settings
augroup my-lua
  autocmd!
  autocmd Filetype lua setlocal textwidth=80
  autocmd Filetype lua setlocal colorcolumn=+1
  autocmd Filetype lua setlocal expandtab
  autocmd Filetype lua setlocal tabstop=4
  autocmd Filetype lua setlocal shiftwidth=4
  autocmd FileType lua autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd FileType lua nmap <Leader>ac :Tabularize /--<CR>
  autocmd FileType lua vmap <Leader>ac :Tabularize /--<CR>
augroup end

NeoBundleSource
