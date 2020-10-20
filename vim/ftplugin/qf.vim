setlocal nowrap
setlocal nobuflisted

nnoremap <buffer> <CR> <CR>
nnoremap <buffer> <BS> <BS>

" open and close quickfix and location lists
" Note: 'yoq' toggles the quickfix, see ../after/plugin/qf.vim
"       'yol' toggles the location, see ../after/plugin/qf.vim
nnoremap [oq :copen<CR>
nnoremap ]oq :cclose<CR>
nnoremap [ol :lopen<CR>
nnoremap ]ol :lclose<CR>

" exchange :cnfile/cpfile and :clast/cfirst mappings from unimpaired
nnoremap ]Q :cnfile<CR>
nnoremap [Q :cpfile<CR>
nnoremap ]<C-Q> :clast<CR>
nnoremap [<C-Q> :cfirst<CR>
nnoremap ]L :lnfile<CR>
nnoremap [L :lpfile<CR>
nnoremap ]<C-L> :llast<CR>
nnoremap [<C-L> :lfirst<CR>

if executable('xdg-open')
  nnoremap <buffer> <leader>p :call system('xdg-open '
    \. fnameescape(fnamemodify(matchstr(getline('.'),'^[^\|]\+'),':r').'.pdf'))<CR>
  nnoremap <buffer> <leader>o :call system('xdg-open '
    \. fnameescape(matchstr(getline('.'),'^[^\|]\+')))<CR>
endif
