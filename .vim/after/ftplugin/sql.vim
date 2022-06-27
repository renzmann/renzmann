setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=120
setlocal expandtab

" TODO this is abandonware now, should probably move to https://github.com/zeroturnaround/sql-formatter
if executable("cli-sql-formatter")
  command! Format exec '%!cli-sql-formatter -u -i 4 %' <bar> exec 'silent redraw!'
else
  exec 'echom "WARNING: sql formatter not found. Try npm install cli-sql-formatter."'
endif
