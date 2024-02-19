" <!> there is a vim-hcl plugin
"
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

setlocal isk+=-

let b:tfbin="terraform"
let b:tfcmd="apply"
let b:tfopt=""

if exists(':VimuxRunCommand')
    " b:cuecmd b:cuecmd b:cueopt %:p
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand b:tfbin . ' ' . b:tfcmd . ' ' . b:tfopt<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand b:tfbin . ' ' . b:tfcmd . ' ' . b:tfopt<CR>

    " TODO GetVisualSelection should be escaped
    " b:cuecmd b:cuecmd b:cueopt -
    " xnoremap <buffer> <F1> :<C-u>VimuxRunCommand 'echo "'.GetVisualSelection().'" \| '.b:tfcmd.' eval -'<CR>

endif
