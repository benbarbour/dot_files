" This comes first, because we have mappings that depend on leader
" With a map leader it's possible to do extra key combinations
let mapleader = ","

" vim-unimpaired like tab navigation
nmap [t :tabprev<CR>
nmap ]t :tabnext<CR>

" vim-unimpaired mappings in terminal mode
tmap [b <C-\><C-n>:bprev<CR>
tmap ]b <C-\><C-n>:bnext<CR>
tmap [t <C-\><C-n>:tabprev<CR>
tmap ]t <C-\><C-n>:tabnext<CR>

" quickly open quickfix/location list window
nnoremap <leader>L :lopen<CR>
nnoremap <leader>Q :copen<CR>

" quickly close quickfix/location list window
nnoremap <leader>x :lclose <bar> cclose<CR>

" quickly jump to the first of the quickfix/location list
nnoremap <leader>q :qfirst<CR>
nnoremap <leader>l :lfirst<CR>

"easily edit/source vim config
nmap <leader>ev :vsplit $MYVIMRC<cr>
nmap <leader>sv :source $MYVIMRC<cr>

" Use ALT-d to drop to null register
nmap <A-d> "_d
"-X drops to null register
nnoremap x "_x

"-Map <C-I> to 'Increment number' and <C-D> to 'Decrement number'
noremap <C-I> <C-A>
noremap <C-D> <C-X>

" Center the screen
nnoremap <space> zz

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

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
  " <leader>-q to exit terminal mode.
  tnoremap <leader>q <C-\><C-n>

  " mappings to move out from terminal to other views
  tnoremap <C-w>h <C-\><C-n><C-w>h
  tnoremap <C-w>j <C-\><C-n><C-w>j
  tnoremap <C-w>k <C-\><C-n><C-w>k
  tnoremap <C-w>l <C-\><C-n><C-w>l
  tnoremap <C-w>s <C-\><C-n><C-w>s
  tnoremap <C-w>v <C-\><C-n><C-w>v
  tnoremap <C-w>o <C-\><C-n><C-w>o
  tnoremap <C-w>w <C-\><C-n><C-w>w

  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>Tb :e term://zsh<CR>i
  tnoremap <leader>Tb <C-\><C-n>:e term://zsh<CR>i
  nnoremap <leader>Tv :vsplit term://zsh<CR>i
  tnoremap <leader>Tv <C-\><C-n>:vsplit term://zsh<CR>i
  nnoremap <leader>Ts :split term://zsh<CR>i
  tnoremap <leader>Ts <C-\><C-n>:split term://zsh<CR>i
  nnoremap <leader>Tt :tabnew term://zsh<CR>i
  tnoremap <leader>Tt <C-\><C-n>:tabnew term://zsh<CR>i

  " turn off line numbering
  autocmd BufWinEnter,WinEnter term://* set nonumber
  autocmd BufWinEnter,WinEnter term://* set norelativenumber
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

function! StripTrailingWhitespaces()
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

" =========================================================
" ==================== Plugin mappings ====================
" =========================================================
nmap <F3>  :UndotreeToggle<CR>
nmap <F4>  :TagbarToggle<CR>
nmap <F12> :call StripTrailingWhitespaces()<CR>

" ==================== vim-choosewin ======================
nmap <C-W>c <Plug>(choosewin)
tnoremap <C-w>c <C-\><C-n>:ChooseWin<CR>

" ====================== Easy Align =======================
nmap gA <Plug>(EasyAlign)
xmap gA <Plug>(EasyAlign)

" ======================== FZF ============================
nnoremap <leader>f :Files .<CR>
nnoremap <leader>B :Buffers<CR>
tnoremap <leader>f <C-\><C-n>:Files .<CR>
tnoremap <leader>B <C-\><C-n>:Buffers<CR>

" ===================== Git Gutter ========================
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" ======================== vim-go =========================
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
augroup end

" ====================== vim-grepper ======================
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nnoremap <leader>/ :Grepper -nojump<CR>
tnoremap <leader>/ <C-\><C-n>:Grepper -nojump<CR>
"
" ====================== delimitMate ======================
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" vim: ts=2 sw=2 et
