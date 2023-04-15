setlocal foldmethod=indent

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'ozc -c '.expand('%:t')<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'ozc -c '.expand('%:t')<CR>
    nnoremap <buffer> <F2> :VimuxRunCommand 'ozengine '.expand('%:t').'f'<CR>
endif
