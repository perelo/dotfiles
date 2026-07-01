

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'nickel eval ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'nickel eval ' . expand('%:p')<CR>
endif
