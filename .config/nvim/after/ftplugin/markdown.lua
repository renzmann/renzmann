-- Use `make %` to convert to html
-- autocmd! FileType markdown setlocal makeprg=python\ -m\ markdown

-- Don't strip whitespace in `md`, since it's used to break lines.
-- let b:noStripWhitespace=1

vim.bo.textwidth = 80
vim.opt_local.spell = true
vim.bo.spelllang = "en_us"
vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2
vim.bo.shiftwidth = 2
vim.bo.fileformat = "unix"
