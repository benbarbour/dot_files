"" Load pathogen
call pathogen#infect()

"" Load Go plugins
set rtp+=/opt/google/go/misc/vim

"" Syntax highlighting and filetype plugins and indents
syntax on
filetype plugin indent on

"" Searching
set nohlsearch                                  " don't highlight matches
set incsearch                                   " incremental searching
set ignorecase                                  " searches are case insensitive...
set smartcase                                   " ... unless they contain at least one capital letter

"" Color Scheme
set t_Co=256
set background=dark
colorscheme peaksea

"" Backup and undo settings
set backupdir=~/.vim/backup//                   "location of backups
set directory=~/.vim/tmp//                      "location of swap files
set dir=~/.vim/tmp//                            "location of swap files
set undofile
set undodir=~/.vim/undodir//
set undolevels=1000                             "maximum number of changes that can be undone
set undoreload=1000                             "maximum number lines to save for undo on a buffer reload

"" SWAGG
let mapleader = ","                             " setting leader to ,
set hidden                                      " allow buffer hiding (Needed for Lusty File Explorer)
set wildignore=*.o                              " ignore these filetypes in menus
set cursorline                                  " shows the horizontal cursor line
set showcmd                                     " display incomplete commands
set nowrap                                      " don't wrap lines
set confirm                                     " confirm saves, if needed
set wildmenu                                    " better command line completion
set wildmode=longest,full                       " bash style filename tab completion
set completeopt+=longest                        " when completing, fill in the longest common text of all matches
set completeopt+=menuone                        " when completing, bring up the menu even if there's only one match
set autoindent                                  " set indent to previous indent
set showmatch                                   " highlight brace, brackets, etc.
set mouse=a                                     " use the mouse
set textwidth=0                                 " don't wrap lines
set wrapmargin=0                                " the wrap margin
set list                                        " show formatting characters
set listchars=tab:>-                            " show tab formatting character only

"" Folding
set foldlevelstart=99

"" Whitespace
set tabstop=4 shiftwidth=4                      " a tab is 4 spaces
set expandtab                                   " use spaces, not tabs
set backspace=indent,eol,start                  " backspace through everything in insert mode

"" Omnicompletion
set completeopt-=preview
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"" Powerline
let g:Powerline_symbols = 'fancy'
set nocompatible                                " Disable vi-compatibility
set laststatus=2                                " Always show the statusline
set encoding=utf-8                              " Necessary to show Unicode glyphs

"" TagBar
" Go support
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
\}
" variables
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 1

"" Highlight whitespace
highlight ExtraWhiteSpace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/

"" PyMode
let g:pymode_lint_ignore=""
let g:pymode_lint_checker="pep8,pyflakes"

"" Python settings
augroup python
    autocmd!
    autocmd Filetype python setlocal expandtab
    autocmd Filetype python setlocal list
    autocmd Filetype python setlocal listchars=tab:>-
    autocmd Filetype python setlocal colorcolumn=80
augroup end

"" Go settings
augroup go
    autocmd!
    autocmd Filetype go setlocal noexpandtab
augroup end



"" Awesome functions
" Open all changed files (as reported by git)
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "edit " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

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

if exists("+showtabline")
    function! MyTabLine()
      let s = '' " complete tabline goes here
      " loop through each tab page
      for t in range(tabpagenr('$'))
        " select the highlighting for the buffer names
        if t + 1 == tabpagenr()
          let s .= '%#TabLineSel#'
        else
          let s .= '%#TabLine#'
        endif
        " empty space
        let s .= ' '
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T'
        " set page number string
        let s .= t + 1 . ':'
        " get buffer names and statuses
        let n = ''  "temp string for buffer names while we loop and check buftype
        let m = 0 " &modified counter
        let bc = len(tabpagebuflist(t + 1))  "counter to avoid last ' '
        " loop through each buffer in a tab
        for b in tabpagebuflist(t + 1)
          " buffer types: quickfix gets a [Q], help gets [H]{base fname}
          " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
          if getbufvar( b, "&buftype" ) == 'help'
            let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
          elseif getbufvar( b, "&buftype" ) == 'quickfix'
            let n .= '[Q]'
          else
            let n .= pathshorten(bufname(b))
            "let n .= bufname(b)
          endif
          " check and ++ tab's &modified count
          if getbufvar( b, "&modified" )
            let m += 1
          endif
          " no final ' ' added...formatting looks better done later
          if bc > 1
            let n .= ' '
          endif
          let bc -= 1
        endfor
        " add modified label [n+] where n pages in tab are modified
        if m > 0
          "let s .= '[' . m . '+]'
          let s.= '+ '
        endif
        " add buffer names
        if n == ''
          let s .= '[No Name]'
        else
          let s .= n
        endif
        " switch to no underlining and add final space to buffer list
        "let s .= '%#TabLineSel#' . ' '
        let s .= ' '
      endfor
      " after the last tab fill with TabLineFill and reset tab page nr
      let s .= '%#TabLineFill#%T'
      " right-align the label to close the current tab page
      if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
      endif
      return s
    endfunction
    set tabline=%!MyTabLine()
endif
"" End Awesome Functionr



"" Mappings (NOTE: inline comments don't work for map commands)

"   tab shortcuts
nnoremap tt :tabnew 
nnoremap td :tabdo 

"   don't delete a single char to a register
nnoremap x "_x

"   use Esc-d (which maps to Alt-d AND META-d in gnome-terminal) to drop to null register
nnoremap <Esc>d "_d

"   edit vimrc quickly
nmap <leader>ev :vsplit $MYVIMRC<cr>
"   source vimrc
nmap <leader>sv :source $MYVIMRC<cr>

"   various plugin toggles
nmap <F2> :NumbersToggle<CR>
nmap <F3> :GundoToggle<CR>
nmap <F4> :TagbarToggle<CR>
nmap <F5> :NERDTreeToggle<CR>

"   build ctags
map <F6> :!/usr/bin/ctags -L $(find . -name "*.c" -o -name "*.h")<CR>

"   decrement and increment number or character under cursor
set nrformats+=alpha
map <F7> <C-X>
map <F8> <C-A>

"   strip trailing whitespace
nmap <F12> :call <SID>StripTrailingWhitespaces()<CR>

"   turn off search highlighting
nmap <F9> :noh<CR>

"   resize windows easily
if bufwinnr(1)
    map + <C-W>+
    map - <C-W>-
endif

"   tab movement mappings
map <leader>1 1gt
map <leader>2 2gt
map <leader>3 3gt
map <leader>4 4gt
map <leader>5 5gt
map <leader>6 6gt
map <leader>7 7gt
map <leader>8 8gt
map <leader>9 9gt
map <leader>0 :tablast<CR>

"   switch to alternate (last) buffer
nmap <C-p> <C-^>

