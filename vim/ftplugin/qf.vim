setlocal nowrap
setlocal nobuflisted

" used by vim-qf plugin
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0


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

function! s:PreviewItem(count)
    let l:qfitem = getqflist()[line('.')-1]
    execute 'keepjumps '
        \ .l:qfitem['bufnr'].'bufdo '
        \ .l:qfitem['lnum'].'z='.(count ? (1+2*a:count) : 3)
    execute 'normal! '
endfunction

nnoremap <buffer> <silent> p :<c-u>call <SID>PreviewItem(v:count)<CR>
