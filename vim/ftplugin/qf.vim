setlocal nowrap
setlocal nobuflisted

" used by vim-qf plugin
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
let g:qf_mapping_ack_style = 1

nnoremap <buffer> <CR> <CR>
nnoremap <buffer> <BS> <BS>

if executable('xdg-open')
  nnoremap <buffer> <leader>p :call system('xdg-open '
    \. fnameescape(fnamemodify(matchstr(getline('.'),'^[^\|]\+'),':r').'.pdf'))<CR>
  nnoremap <buffer> <leader>o :call system('xdg-open '
    \. fnameescape(matchstr(getline('.'),'^[^\|]\+')))<CR>
endif
