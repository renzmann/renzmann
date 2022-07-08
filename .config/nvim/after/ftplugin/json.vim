syntax match Comment +\/\/.\+$+
let s:path = expand('<sfile>:p:h')
let s:escaped = fnameescape(s:path.'/javascript.vim')
:execute 'source '.s:escaped

