local = vim.opt_local
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.textwidth = 120
o.expandtab = true

-- TODO this is abandonware now, should probably move to https://github.com/zeroturnaround/sql-formatter
-- if executable("cli-sql-formatter")
--   command! Format exec '%!cli-sql-formatter -u -i 4 %' <bar> exec 'silent redraw!'
-- else
--   exec 'echom "WARNING: sql formatter not found. Try npm install cli-sql-formatter."'
-- endif
