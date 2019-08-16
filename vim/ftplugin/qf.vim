setlocal nowrap
setlocal nobuflisted

" map like jumpy.vim but with } and {
let g:qf_next_file_re = '\%#=1\v^([^\|]+).*\n\1@!\zs'
vnoremap <buffer> <silent> } m':<C-U>exe "normal! gv"<bar>exe "call search('".g:qf_next_file_re."', 'W')"<CR>
nnoremap <buffer> <silent> } m':exe "call search('".g:qf_next_file_re."', 'W')"<CR>
vnoremap <buffer> <silent> { m':<C-U>exe "normal! gv"<bar>exe "call search('".g:qf_next_file_re."', 'bW')"<CR>
nnoremap <buffer> <silent> { m':exe "call search('".g:qf_next_file_re."', 'bW')"<CR>
