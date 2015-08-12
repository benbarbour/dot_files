let g:unite_source_history_yank_enable = 1

nnoremap <leader>/ :Unite -no-split grep:.<cr>
nnoremap <leader>y :Unite -no-split -start-insert history/yank<cr>
nnoremap <leader>f :Unite -no-split -start-insert file_rec/async<cr>
nnoremap <leader>b :Unite -no-split buffer<cr>

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

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'ignore_pattern', join([
            \ '\.swp', '\.swo', '\~$',
            \ '\.git/', '\.svn/', '\.hg/',
            \ '^tags$', '\.taghl$',
            \ '\.ropeproject/', '\.pbxproj$', '\.xcodeproj', '\.vcproj', 
            \ 'node_modules/', 'log/', 'tmp/', 'obj/',
            \ '/vendor/gems/', '/vendor/cache/', '\.bundle/', '\.sass-cache/',
            \ '/tmp/cache/assets/.*/sprockets/', '/tmp/cache/assets/.*/sass/',
            \ 'thirdparty/', 'Debug/', 'Release/',
            \ '\.pyc$', 'pb2\.py$', '\.class$', '\.jar$', '\.min\.js$',
            \ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
            \ '\.o$', '\.out$', '\.obj$', '\.rbc$', '\.rbo$', '\.gem$',
            \ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$'
            \ ], '\|'))
let g:unite_source_rec_max_cache_files = 0
call unite#custom#source('file_rec,file_rec/async,file_mru,file,buffer,grep',
            \ 'max_candidates', 0)

call unite#custom#profile('default', 'context', {
    \   'prompt': '» ',
    \   'start_insert': 1,
    \   'update_time': 200,
    \   'direction': 'botright',
    \   'prompt_direction': 'top',
    \ })

let g:unite_source_buffer_time_format = "%Y-%m-%d  %H:%M:%S  "
let g:unite_source_file_mru_time_format = "%Y-%m-%d  %H:%M:%S  "

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
elseif executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden --ignore-case --ignore tags'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
              \ '--no-heading --no-color -a -H'
  let g:unite_source_grep_recursive_opt = ''
endif
