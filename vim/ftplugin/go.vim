" add "tab:   " to listchars -- overrides previously set tab:‣·
" exe "set listchars=".&lcs.",tab:\ \ "
setl listchars-=tab:‣·
setl listchars+=tab:\ \ 

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'go run ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'go run ' . expand('%:p')<CR>

    nnoremap <buffer> <F2> :silent w <bar> VimuxRunLastCommand<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>
endif
