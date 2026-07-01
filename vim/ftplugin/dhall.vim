set sw=4 ts=4 sts=4

" ../after/plugin/vim-lsp.vim

if exists(':VimuxRunCommand')
    " 'cue eval --simplify ' %:p
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'dhall --file ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'dhall --file ' . expand('%:p')<CR>

endif
