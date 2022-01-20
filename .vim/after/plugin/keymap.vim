" =============================================================================
"                              Keyboard Shortcuts
" =============================================================================
" Search for [<letter>] to see what's mapped under <leader><letter>.
" e.g. /[s] will take you to the settings navigation section.

" Faster scrolling
nnoremap <C-e>                2<C-E>
nnoremap <C-y>                2<C-Y>

" Make spacebar the leader key
let mapleader=" "
nnoremap <Space> <Nop>

" Case-insensitive search
nnoremap <leader>/            /\c<Left><Left>

" Make `cgn` operate on the currently selected word
" https://vi.stackexchange.com/a/18895
nnoremap <silent> cgn :let @/=expand('<cword>')<cr>cgn

" [v]imscript execution
" -----------------------------------------------------------------------
" Execute the whole line under cursor in normal mode
nnoremap <silent><leader>ve   yy:@"<CR>0
" Execute visual selection
vnoremap <silent><leader>ve   y:@"<CR>

" Select 'in next' or 'in last' thing
" -----------------------------------------------------------------------
onoremap in(                  :<C-U>normal! f(vi(<CR>
onoremap in[                  :<C-U>normal! f[vi[<CR>
onoremap in"                  :<C-U>normal! f"vi"<CR>
onoremap in'                  :<C-U>normal! f'vi'<CR>
onoremap il"                  :<C-U>normal! F"vi"<CR>
onoremap il'                  :<C-U>normal! F'vi'<CR>
onoremap il(                  :<C-U>normal! F)vi(<CR>
onoremap il[                  :<C-U>normal! F]vi[<CR>
onoremap i;                   :<C-U>execute "normal! v/;\rhs"<CR>

" [s]ettings navigation
" -----------------------------------------------------------------------
nnoremap <silent><leader>si   :<C-u>e $MYVIMRC<CR>
nnoremap <silent><leader>sn   :<C-u>e $MYVIMHOME/init.vim<CR>
nnoremap <silent><leader>sv   :<C-u>e $MYVIMHOME/vimrc<CR>
nnoremap <silent><leader>sk   :<C-u>e $MYVIMHOME/plugin/keymap.vim<CR>
nnoremap <silent><leader>sp   :<C-u>e $MYVIMHOME/plugin<CR>
nnoremap <silent><leader>so   :<C-u>e $MYVIMHOME/after/ftplugin<CR>

" [p]ut files in a :Lexplore window
nnoremap <silent><leader>p    :<C-u>20Lexplore<CR>

" Capitalize last word while inserting text
" -----------------------------------------------------------------------
inoremap <C-j>                <Esc>viwUea

" Markdown and RST headers
" -----------------------------------------------------------------------
nnoremap <leader>1            yypVr=
nnoremap <leader>2            yypVr-
nnoremap <leader>3            yypVr+
nnoremap <leader>4            yypVr*
onoremap ih                   :<C-U>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>

" Tab movement
" -----------------------------------------------------------------------
" [h]
nnoremap <silent><leader>h    :<C-u>tabp<CR>
" [l]
nnoremap <silent><leader>l    :<C-u>tabn<CR>

" [c]lipboard [c]ommands
" -----------------------------------------------------------------------
nnoremap <leader>cv           "+p
vnoremap <leader>cv           "+p
vnoremap <leader>cc           "+y

" [f]in[d] [b]uffers and [t]hin[g]s
" -----------------------------------------------------------------------
nnoremap <leader>f          :Files<CR>
nnoremap <leader>b          :Buffers<CR>
nnoremap <leader>g          :GitFiles<CR>
nnoremap <leader>t          :Tags<CR>
nnoremap <leader>d          :Rg<CR>
