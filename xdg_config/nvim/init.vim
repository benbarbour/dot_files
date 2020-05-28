function! <SID>SourceConf(filename)
  let PATH=stdpath('config') . '/config/' . a:filename . '.vim'
  if empty(glob(PATH))
    echo "No such file: ".PATH
  else
    execute "source ".PATH
  endif
endfunction

call <SID>SourceConf("settings")
call <SID>SourceConf("commands")
call <SID>SourceConf("keys")
call <SID>SourceConf("plugins")
