" Use `make %` to convert to html
autocmd! FileType markdown setlocal makeprg=python\ -m\ markdown

" Don't strip whitespace in `md`, since it's used to break lines.
let b:noStripWhitespace=1
