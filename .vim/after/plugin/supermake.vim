if exists("g:loaded_supermake")
  finish
end
let g:loaded_supermake = 1

" See grep.vim for the inspiration of this
function! Make(...)
  return system(join([&makeprg] + [expand(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Make  cgetexpr Make(<f-args>)

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
augroup END
