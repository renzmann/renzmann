vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.fileformat = "unix"
vim.bo.textwidth = 120

-- local bufmap = function(mode, lhs, rhs)
--    vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, { noremap = true, silent = true})
-- end

-- nnoremap <silent><buffer> [[ m':call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
-- bufmap("n", "[[", [[call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")]])

-- vnoremap <silent><buffer> [[ m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")<CR>
-- bufmap("v", "[[", vim.cmd([[exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "bW")]]))

-- nnoremap <silent><buffer> ]] m':call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
-- bufmap("n", "]]", vim.cmd([[call search('^\s*\(fu\%[nction]\\|def\)\>', "W")]]))

-- vnoremap <silent><buffer> ]] m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "W")<CR>
-- bufmap("v", "]]", vim.cmd([[exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|def\)\>', "W")]]))

-- nnoremap <silent><buffer> [] m':call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
-- bufmap("n", "[]", vim.cmd([[call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")]]))

-- vnoremap <silent><buffer> [] m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")<CR>
-- bufmap("v", "[]", vim.cmd([[exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "bW")]]))

-- nnoremap <silent><buffer> ][ m':call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>
-- bufmap("n", "][", vim.cmd([[call search('^\s*end\(f\%[unction]\\|def\)\>', "W")]]))

-- vnoremap <silent><buffer> ][ m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "W")<CR>
-- bufmap("v", "][", vim.cmd([[exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|def\)\>', "W")]]))
