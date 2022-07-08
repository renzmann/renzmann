-- Use `make %` to convert to html
-- autocmd! FileType markdown setlocal makeprg=python\ -m\ markdown

-- Don't strip whitespace in `md`, since it's used to break lines.
-- let b:noStripWhitespace=1

local o = vim.opt_local
o.textwidth = 80
o.spell = true
o.spelllang = "en_us"
o.tabstop = 2
o.expandtab = true
o.softtabstop = 2
o.shiftwidth = 2
o.fileformat = "unix"
