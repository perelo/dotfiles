setlocal ts=4 sw=4 sts=4

set commentstring=//\ %s

let g:jsonnet_fmt_on_save = 0
let g:jsonnet_fmt_options = '-n ' . &ts

let g:jsonnet_command='jsonnet'

let b:cmd = g:jsonnet_command.' '.expand('%:p')
if exists(':VimuxRunCommand')
    noremap <buffer> <F1>      :silent w <bar> VimuxRunCommand b:cmd<CR>
    noremap <buffer> <F2>      <Esc>:silent w <bar> VimuxRunCommand b:cmd.' -S'<CR>
    " nnoremap <buffer> <F2> :silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
    " inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' - \| '.b:wild_life<CR>
endif
