if exists("g:loaded_editftplugin")
  finish
end
let g:loaded_editftplugin = 1

command! -nargs=1 FtEdit :e ~/.config/nvim/after/ftplugin/<args>.vim
command! -nargs=1 FuncEdit :e ~/.bash_functions/<args>.vim
