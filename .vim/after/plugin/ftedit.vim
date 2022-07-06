if exists("g:loaded_editftplugin")
  finish
end
let g:loaded_editftplugin = 1

command! -nargs=1 FtEdit   :<C-u>edit $MYVIMHOME/after/ftplugin/<args>.vim
command! -nargs=1 FuncEdit :<C-u>edit ~/.bash_functions/<args>.sh
command! -nargs=1 CmdEdit  :<C-u>edit ~/.local/bin/<args>
