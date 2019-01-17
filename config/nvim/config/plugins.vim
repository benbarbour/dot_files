call plug#begin('~/.config/nvim/plugged')

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Raimondi/delimitMate'            " auto insertion of closing tokens like parens and quotes.
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'                    " utilities for the go programming language
Plug 'fisadev/vim-isort'
Plug 'itchyny/lightline.vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'junegunn/vim-easy-align'         " align text to columns in an interactive manner
Plug 'majutsushi/tagbar'               " display file outline in tagbar
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'qpkorr/vim-bufkill'              " add uppercase BD and BW commands that don't mess up splits
Plug 't9md/vim-choosewin'              " tmux-like window chooser
Plug 'tpope/vim-abolish'               " Case-matching substitution, abbreviation, and coercion
Plug 'tpope/vim-characterize'          " Press ga on a character to view encodings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'                " allows repeate key (.) to work with more things
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'                 " back Tmux commanys (:Tyank, :Tput)
Plug 'tpope/vim-unimpaired'            " short normal mode aliases for commonly used ex commands
Plug 'tpope/vim-sleuth'                " autmatically detect indent settings
Plug 'severin-lemaignan/vim-minimap'
Plug 'unblevable/quick-scope'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'         " up-to-date javascript syntax highlighting

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }  " fuzzy finder
Plug 'junegunn/fzf.vim'                                             " fuzzy finder vim settings

Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'

if has('nvim')
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'zchee/deoplete-go', { 'do': 'make'}
  Plug 'zchee/deoplete-jedi'
else
  Plug 'Shougo/neocomplete.vim'
  Plug 'tpope/vim-sensible'
endif

Plug 'altercation/vim-colors-solarized'

" filetype plugins
Plug 'sheerun/vim-polyglot'

call plug#end()

" vim: ts=2 sw=2 et
