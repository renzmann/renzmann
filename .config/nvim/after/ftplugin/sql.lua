vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.shiftwidth = 4
vim.bo.textwidth = 120
vim.bo.expandtab = true

-- TODO this is abandonware now, should probably move to https://github.com/zeroturnaround/sql-formatter
-- if executable("cli-sql-formatter")
--   command! Format exec '%!cli-sql-formatter -u -i 4 %' <bar> exec 'silent redraw!'
-- else
--   exec 'echom "WARNING: sql formatter not found. Try npm install cli-sql-formatter."'
-- endif
