" All keyboard shortcuts should go here.
" ======================================

" This comes first, because we have mappings that depend on leader.
" With a map leader it's possible to do extra key combinations.
let mapleader = ","

" Null register mappings
" ======================
nmap <A-d> "_d
nnoremap x "_x

" Better split switching
" ======================
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" vim-unimpaired like tab navigation
" ==================================
nnoremap [t :tabprev<CR>
nnoremap ]t :tabnext<CR>

" Search improvements
" ===================
" These will make it so that going to the next one in a search will center on
" the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <leader>7 :nohlsearch<CR>
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

"-Map <C-I> to 'Increment number' and <C-D> to 'Decrement number'
noremap <C-I> <C-A>
noremap <C-D> <C-X>

" Terminal keybindings
" ====================
if has('nvim')
  " <leader>-q to exit terminal mode.
  tnoremap <leader>q <C-\><C-n>

  " make <C-w> work in term mode
  tnoremap <C-w> <C-\><C-n><C-w>

  " Open terminal in vertical, horizontal and new tab
  nnoremap <leader>Tb :e term://zsh<CR>i
  tnoremap <leader>Tb <C-\><C-n>:e term://zsh<CR>i
  nnoremap <leader>Tv :vsplit term://zsh<CR>i
  tnoremap <leader>Tv <C-\><C-n>:vsplit term://zsh<CR>i
  nnoremap <leader>Ts :split term://zsh<CR>i
  tnoremap <leader>Ts <C-\><C-n>:split term://zsh<CR>i
  nnoremap <leader>Tt :tabnew term://zsh<CR>i
  tnoremap <leader>Tt <C-\><C-n>:tabnew term://zsh<CR>i

  " vim-unimpaired mappings in terminal mode
  tmap [b <C-\><C-n>:bprev<CR>
  tmap ]b <C-\><C-n>:bnext<CR>
  tmap [t <C-\><C-n>:tabprev<CR>
  tmap ]t <C-\><C-n>:tabnext<CR>
endif
