

nnoremap <F1> <buffer> :w<CR>:VimuxRunCommand 'gcc '.expand('%').' -o '.expand('%:t:r')<CR>
inoremap <F1> <buffer> <Esc>:w<CR>:VimuxRunCommand 'gcc '.expand('%').' -o '.expand('%:t:r')<CR>

nnoremap <F2> <buffer> :w<CR>:VimuxRunCommand './'.expand('%:t:r')<CR>
inoremap <F2> <buffer> <Esc>:w<CR>:VimuxRunCommand './'.expand('%:t:r')<CR>
