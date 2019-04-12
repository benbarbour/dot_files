" ===================== FZF =========================
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
let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'


" ===================== Git Gutter =================
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 0


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

augroup vim-go-aucmds
  autocmd!
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup end


" ==================== vim-grepper ====================
runtime plugin/grepper.vim    " initialize g:grepper with default values
let g:grepper.tools  = ['git', 'ag', 'pt', 'grep']
let g:grepper.open   = 1
let g:grepper.jump   = 0
let g:grepper.switch = 1
let g:grepper.prompt_quote = 1
let g:grepper.dir = 'repo,cwd'


" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1
let g:delimitMate_expand_inside_quotes = 0
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'


" ==================== Completion =========================
let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

" Use partial fuzzy matches like YouCompleteMe
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])


" ==================== vim-choosewin ======================
let g:choosewin_keymap = {
      \ '0':     '<NOP>',
      \ '[':     '<NOP>',
      \ ']':     '<NOP>',
      \ '$':     '<NOP>',
      \ 'x':     '<NOP>',
      \ ';':     'win_land',
      \ '-':     'previous',
      \ 's':     'swap',
      \ 'S':     'swap_stay',
      \ "\<CR>": 'win_land',
      \ }
let g:choosewin_label = '1234567890'
let g:choosewin_tablabel = 'ABCDEFGHIJKLMNOPQRTUVWYZ'


" ================== Quick Scope ===================
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']


" =================== vim-isort ====================
" disable visual isort mapping
let g:vim_isort_map = ''

" =================== ALE ====================
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linters = {
\  'javascript': ['eslint'],
\}
let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1

" vim: ts=2 sw=2 et
