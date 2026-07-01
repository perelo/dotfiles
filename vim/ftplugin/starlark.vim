set sw=4 ts=4 sts=4

if exists(':VimuxRunCommand')
    " 'cue eval --simplify ' %:p
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'starlark ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'starlark  ' . expand('%:p')<CR>

endif
