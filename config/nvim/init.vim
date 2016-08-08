" based heavily on https://github.com/fatih/dotfiles/blob/master/init.vim

call plug#begin('~/.config/nvim/plugged')

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Raimondi/delimitMate'            " auto insertion of closing tokens like parens and quotes.
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'                    " utilities for the go programming language
Plug 'fisadev/vim-isort'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/vim-easy-align'         " align text to columns in an interactive manner
Plug 'majutsushi/tagbar'               " display file outline in tagbar
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'myusuf3/numbers.vim'             " Relative line numbers
Plug 'qpkorr/vim-bufkill'              " add uppercase BD and BW commands that don't mess up splits
Plug 't9md/vim-choosewin'              " tmux-like window chooser
Plug 'tpope/vim-abolish'               " Case-matching substitution, abbreviation, and coercion
Plug 'tpope/vim-characterize'          " Press ga on a character to view encodings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'                " allows repeate key (.) to work with more things
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'                 " back Tmux commanys (:Tyank, :Tput)
Plug 'tpope/vim-unimpaired'            " short normal mode aliases for commonly used ex commands
Plug 'unblevable/quick-scope'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }  " fuzzy finder
Plug 'junegunn/fzf.vim'                                             " fuzzy finder vim settings

if has('nvim')
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'zchee/deoplete-jedi'
else
  Plug 'Shougo/neocomplete.vim'
endif

if has('nvim')
  Plug 'frankier/neovim-colors-solarized-truecolor-only'
else
  Plug 'altercation/vim-colors-solarized'
endif

" filetype plugins
Plug 'vim-ruby/vim-ruby'
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'fatih/vim-nginx' , {'for' : 'nginx'}
Plug 'corylanou/vim-present', {'for' : 'present'}

call plug#end()

"=====================================================
"===================== SETTINGS ======================

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
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set background=dark
colorscheme solarized
highlight ColorColumn ctermbg=52
highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=196

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

"=====================================================
"===================== MAPPINGS ======================

" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
" i.e: <leader>w saves the current file
let mapleader = ","

nmap <leader>ev :vsplit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>
" Use ALT-d to drop to null register
nmap <A-d> "_d
"-X drops to null register
nnoremap x "_x

"-Map <C-I> to 'Increment number' and <C-D> to 'Decrement number'
noremap <C-I> <C-A>
noremap <C-D> <C-X>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Source the current Vim file
nnoremap <leader>pr :Runtime<CR>

" Close all but the current one
nnoremap <leader>o :only<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Print full path
map <C-f> :echo expand("%:p")<cr>

" Terminal settings
if has('nvim')
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <Leader>q <C-\><C-n>gg<cr>

  " mappings to move out from terminal to other views
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l

  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>tv :vsplit term://zsh<CR>
  nnoremap <leader>ts :split term://zsh<CR>
  nnoremap <leader>tt :tabnew term://zsh<CR>

  " always start terminal in insert mode
  autocmd BufWinEnter,WinEnter term://* startinsert
endif

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Source (reload configuration)
nnoremap <silent> <F5> :source $MYNVIMRC<CR>

nnoremap <F6> :setlocal spell! spell?<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Act like D and C
nnoremap Y y$

" Do not show stupid q: window
map q: :q

" Don't move on * I'd use a function for this but Vim clobbers the last search
" when you're in a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
if !has('gui_running')
  set notimeout
  set ttimeout
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

" Visual Mode */# from Scrooloose {{{
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>


"====================================================
"===================== PLUGINS ======================

" ===================Easy Align =====================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" ===================== FZF =========================
nnoremap <leader>f :Files .<CR>
nnoremap <leader>b :Buffers<CR>
let g:fzf_buffers_jump = 1
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" ===================== Git Gutter =================
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" ==================== vim-go ====================
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 0
let g:go_list_type = "quickfix"

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup vim-go-cmds
  autocmd!

  autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  autocmd FileType go nmap <leader>m :<C-u>call <SID>build_go_files()<CR>
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup end

" prependend
function! s:CreateGoDocComment()
  norm "zyiw
  execute ":put! z"
  execute ":norm I# \<Esc>$"
endfunction

nnoremap <leader>ui :<C-u>call <SID>CreateGoDocComment()<CR>

" ==================== vim-grepper ====================
let g:grepper        = {}
let g:grepper.tools  = ['git', 'ag', 'pt', 'grep']
let g:grepper.open   = 1
let g:grepper.jump   = 0
let g:grepper.switch = 1
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nnoremap <leader>/ :Grepper -nojump<CR>

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" ==================== Lightline ====================
"
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'fugitive', 'filename', 'modified' ],
      \             [ 'go'] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'go'] ],
      \ },
      \ 'component_function': {
      \   'lineinfo': 'LightLineInfo',
      \   'percent': 'LightLinePercent',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'go': 'LightLineGo',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'fugitive': 'LightLineFugitive',
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

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineInfo()
  return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfunction

function! LightLinePercent()
  return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfunction

function! LightLineFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LightLineGo()
  " return ''
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  if mode() == 't'
    return ''
  endif

  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]')
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ==================== Completion =========================
" I use deoplete for Neovim and neocomplete for Vim.
if has('nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#ignore_sources = {}
  let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
  let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1

  " Use partial fuzzy matches like YouCompleteMe
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
  call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
  call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])
else
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3

  if !exists('g:neocomplete#sources')
    let g:neocomplete#sources = {}
  endif
  let g:neocomplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary']
  let g:neocomplete#sources.go = ['omni']

  " disable sorting
  call neocomplete#custom#source('_', 'sorters', [])
endif

" ==================== UltiSnips ====================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" ========================= Functions ===================================
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    :silent! %s/\s\+$//e
    :silent! %s#\($\n\s*\)\+\%$##
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" ==================== Various other plugin settings ====================
nmap  -  <Plug>(choosewin)

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

nmap <F3>  :UndotreeToggle<CR>
nmap <F4>  :TagbarToggle<CR>
nmap <F12> :call <SID>StripTrailingWhitespaces()<CR>

" disable visual isort mapping
let g:vim_isort_map = ''

"====================================================
"==================== FILE TYPES ====================

augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.go setf go
augroup END

augroup python-cmds
  autocmd!
  autocmd FileType python setlocal expandtab ts=4 sw=4 sts=4
  autocmd FileType python setlocal textwidth=79 colorcolumn=+1
  autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

augroup lua-cmds
  autocmd!
  autocmd FileType lua setlocal expandtab ts=4 sw=4 sts=4
  autocmd FileType lua setlocal textwidth=79 colorcolumn=+1
  autocmd FileType lua setlocal spell
  autocmd FileType lua autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
augroup end

augroup markdown-cmds
  autocmd!
  autocmd FileType markdown setlocal wrap
  autocmd FileType markdown setlocal nolist
  autocmd FileType markdown setlocal linebreak
  autocmd FileType markdown setlocal noexpandtab ts=4 sw=4 sts=4
  autocmd FileType markdown setlocal textwidth=79 colorcolumn=+1
  autocmd FileType markdown setlocal spell
augroup end

augroup go-cmds
  autocmd!
  autocmd FileType go setlocal nolist
  autocmd FileType go setlocal noexpandtab ts=2 sw=2 sts=2
  autocmd FileType go setlocal textwidth=89 colorcolumn=+1
  autocmd FileType go setlocal spell
augroup end

augroup make-cmds
  autocmd!
  autocmd FileType make setlocal nolist
  autocmd FileType make setlocal noexpandtab ts=4 sw=4 sts=4
  autocmd FileType make setlocal spell
augroup end

" vim: ts=2 sw=2 et
