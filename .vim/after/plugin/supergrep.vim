" From the excellent article by /u/romainl
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
if exists("g:loaded_supergrep")
  finish
end
let g:loaded_supergrep = 1

if executable('rg')
  set grepprg=rg\ --vimgrep\ -i
endif

function! Grep(...)
  return system(join([&grepprg] + [expand(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

" `==#` checks equality with case matching. The ternary here checks if we are on
" the command line and that the expression is exactly "grep". If so, change it
" to "Grep". Otherwise, the "grep" stays in place, since we're not on the
" command line.
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
