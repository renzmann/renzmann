if exists("g:loaded_editftplugin")
  finish
end
let g:loaded_editftplugin = 1

command! -nargs=1 FtEdit   :edit $MYVIMHOME/after/ftplugin/<args>.vim
command! -nargs=1 FuncEdit :edit ~/.bash_functions/<args>.sh
command! -nargs=1 CmdEdit  :edit ~/.local/bin/<args>
