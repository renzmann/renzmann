let s:path = expand('<sfile>:p:h')
let s:escaped = fnameescape(s:path.'/html.vim')
:execute 'source '.s:escaped
