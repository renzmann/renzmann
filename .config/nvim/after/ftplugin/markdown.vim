" Use `make %` to convert to html
autocmd! FileType markdown setlocal makeprg=python\ -m\ markdown

" Don't strip whitespace in `md`, since it's used to break lines.
let b:noStripWhitespace=1

setlocal textwidth=80
setlocal spell spelllang=en_us
setlocal tabstop=2
setlocal expandtab
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal fileformat=unix
