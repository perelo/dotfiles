setlocal foldmethod=indent

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> call VimuxRunCommandInDir('ozc -c '.expand('%:t'), 0)<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> call VimuxRunCommandInDir('ozc -c '.expand('%:t'), 0)<CR>
    nnoremap <buffer> <F2> :call VimuxRunCommandInDir('ozengine '.expand('%:t').'f', 0)<CR>
endif
