if exists("g:loaded_tmuxkeys")
  finish
end
let g:loaded_tmuxkeys = 1


if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on.
    " Make sure `set-window-option -g xterm-keys on` is in ~/.tmux.conf
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
