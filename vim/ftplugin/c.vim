

nnoremap <buffer> <F1> :w<CR>:VimuxRunCommand 'gcc '.expand('%').' -o '.expand('%:t:r')<CR>
inoremap <buffer> <F1> <Esc>:w<CR>:VimuxRunCommand 'gcc '.expand('%').' -o '.expand('%:t:r')<CR>

nnoremap <buffer> <F2> :w<CR>:VimuxRunCommand './'.expand('%:t:r')<CR>
inoremap <buffer> <F2> <Esc>:w<CR>:VimuxRunCommand './'.expand('%:t:r')<CR>
