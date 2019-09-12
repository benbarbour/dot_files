call plug#begin('~/.config/nvim/plugged')

" Plugins
" ============

Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'Raimondi/delimitMate'                                         " auto insertion of closing tokens like parens and quotes.
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'                             " colorscheme
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                  " utilities for the go programming language
Plug 'fisadev/vim-isort'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }  " fuzzy finder
Plug 'junegunn/fzf.vim'                                             " fuzzy finder vim settings
Plug 'junegunn/vim-easy-align'                                      " align text to columns in an interactive manner
Plug 'majutsushi/tagbar'                                            " display file outline in tagbar
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'pangloss/vim-javascript'                                      " up-to-date javascript syntax highlighting
Plug 'qpkorr/vim-bufkill'                                           " add uppercase BD and BW commands that don't mess up splits
Plug 'sbdchd/neoformat'
Plug 't9md/vim-choosewin'                                           " tmux-like window chooser
Plug 'tpope/vim-abolish'                                            " Case-matching substitution, abbreviation, and coercion
Plug 'tpope/vim-characterize'                                       " Press ga on a character to view encodings
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'                                             " allows repeate key (.) to work with more things
Plug 'tpope/vim-sleuth'                                             " autmatically detect indent settings
Plug 'tpope/vim-surround'
Plug 'tpope/vim-tbone'                                              " back Tmux commanys (:Tyank, :Tput)
Plug 'tpope/vim-unimpaired'                                         " short normal mode aliases for commonly used ex commands
Plug 'unblevable/quick-scope'
Plug 'w0rp/ale'

" filetype plugins
Plug 'sheerun/vim-polyglot'
Plug 'brodie/cram', {'do': 'mkdir -p syntax; cp -f contrib/*.vim syntax/'}

call plug#end()

" vim: ts=2 sw=2 et
