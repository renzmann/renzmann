local o = vim.opt_local

vim.cmd [[syntax match Comment +\/\/.\+$+]]
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.fileformat = unix
o.expandtab = true
o.textwidth = 120
