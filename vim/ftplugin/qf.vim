setlocal nowrap
setlocal nobuflisted

" map like jumpy.vim but with } and {
let g:qf_next_file_re = '\%#=1\v^([^\|]+).*\n\1@!\zs'
vnoremap <buffer> <silent> } m':<C-U>exe "normal! gv"<bar>exe "call search('".g:qf_next_file_re."', 'W')"<CR>
nnoremap <buffer> <silent> } m':exe "call search('".g:qf_next_file_re."', 'W')"<CR>
vnoremap <buffer> <silent> { m':<C-U>exe "normal! gv"<bar>exe "call search('".g:qf_next_file_re."', 'bW')"<CR>
nnoremap <buffer> <silent> { m':exe "call search('".g:qf_next_file_re."', 'bW')"<CR>

if executable('xdg-open')
  nnoremap <buffer> <leader>p :call system('xdg-open '
    \. fnameescape(fnamemodify(matchstr(getline('.'),'^[^\|]\+'),':r').'.pdf'))<CR>
  nnoremap <buffer> <leader>o :call system('xdg-open '
    \. fnameescape(matchstr(getline('.'),'^[^\|]\+')))<CR>
endif
