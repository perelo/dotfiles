" remap <CR> and <BS> to do to top/bottom of buffer
nnoremap <CR> G
nnoremap <BS> gg

" but don't do it in quickfix or Command Line window
augroup cr_bs
    au!
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <buffer> <BS> <BS>
    autocmd CmdwinEnter * nnoremap <buffer> <BS> <BS>
augroup END
