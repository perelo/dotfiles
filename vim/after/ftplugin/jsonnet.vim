setlocal ft=2 sw=2 sts=2


let g:jsonnet_fmt_on_save = 1

" TODO guard this
let g:jsonnet_command='jsonnet'

let b:cmd = g:jsonnet_command.' '.expand('%:p')
if exists(':VimuxRunCommand')
    noremap <buffer> <F1>      :silent w <bar> VimuxRunCommand b:cmd<CR>
    " nnoremap <buffer> <F2> :silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
    " inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
endif
