
" filetype detected in ../plugin/autocmds.vim
setlocal commentstring=\%\ %s

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand './wild_life < '.expand('%:p')<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand './wild_life < '.expand('%:p')<CR>
    nnoremap <buffer> <F2> :silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| ./wild_life'<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| ./wild_life'<CR>
endif
