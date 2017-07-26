" based on:
"   - https://github.com/fatih/dotfiles/blob/master/init.vim
"   - https://www.gregjs.com/vim/2016/do-yourself-a-favor-and-modularize-your-vimrc-init-vim/

function! <SID>SourceConf(filename)
  let PATH='$HOME/.config/nvim/config/'.a:filename.'.vim'
  if empty(glob(PATH))
    echo "No such file: ".PATH
  else
    execute "source ".PATH
  endif
endfunction

call <SID>SourceConf('plugins')
call <SID>SourceConf('settings')
call <SID>SourceConf('plugin_conf')
call <SID>SourceConf('colors')
call <SID>SourceConf('keys')
call <SID>SourceConf('statusline')
call <SID>SourceConf('types')

" Stuff that should only exist at work or home or wherever can go in the
" local file, which should be untracked by git.
call <SID>SourceConf('local')

" vim: ts=2 sw=2 et
