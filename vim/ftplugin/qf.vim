setlocal nowrap
setlocal nobuflisted

nnoremap <buffer> <CR> <CR>
nnoremap <buffer> <BS> <BS>

if executable('xdg-open')
  nnoremap <buffer> <leader>p :call system('xdg-open '
    \. fnameescape(fnamemodify(matchstr(getline('.'),'^[^\|]\+'),':r').'.pdf'))<CR>
  nnoremap <buffer> <leader>o :call system('xdg-open '
    \. fnameescape(matchstr(getline('.'),'^[^\|]\+')))<CR>
endif
