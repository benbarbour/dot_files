augroup filetypedetect
  autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf* setf tmux
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  autocmd BufNewFile,BufRead *.go setf go
augroup END

augroup python-cmds
  autocmd!
  autocmd FileType python setlocal expandtab ts=4 sw=4 sts=4
  autocmd FileType python setlocal textwidth=79 colorcolumn=+1
  autocmd FileType python autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()
  autocmd FileType python :iabbrev <buffer> pdb import pdb; pdb.set_trace()
augroup end

augroup lua-cmds
  autocmd!
  autocmd FileType lua setlocal expandtab ts=4 sw=4 sts=4
  autocmd FileType lua setlocal textwidth=79 colorcolumn=+1
  autocmd FileType lua setlocal spell
  autocmd FileType lua autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()
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

augroup cpp-cmds
  autocmd!
  autocmd FileType cpp,cc setlocal commentstring=//\ %s
  autocmd FileType cpp,cc let b:delimitMate_matchpairs = "(:),[:],{:}"
augroup end

autocmd BufNewFile,BufRead /**/COMMIT_EDITMSG setlocal spell

augroup fmt
  autocmd!
  " autocmd BufWritePre *.c,*.cc,*.cpp,*.h Neoformat
augroup end

augroup javascript
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

" vim: ts=2 sw=2 et
