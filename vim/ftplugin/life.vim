
" filetype detected in ../plugin/autocmds.vim
setlocal commentstring=\%\ %s

let b:wild_life = '~/workspace/iac/Life1.01/Source/wild_life'
if exists(':VimuxRunCommand') && filereadable(b:wild_life)
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand b:wild_life.' < '.expand('%:p')<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand b:wild_life.' < '.expand('%:p')<CR>
    nnoremap <buffer> <F2> :silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
endif
