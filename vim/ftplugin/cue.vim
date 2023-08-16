setlocal nolist  " because formatting uses tabs
setlocal iskeyword+=#   " so that Definitions (e.g. #List) are words

let b:cuecmd="cue"

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand b:cuecmd.' eval '.expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand b:cuecmd.' eval '.expand('%:p')<CR>

    " TODO GetVisualSelection should be escaped
    xnoremap <buffer> <F1> :<C-u>VimuxRunCommand 'echo "'.GetVisualSelection().'" \| '.b:cuecmd.' eval -'<CR>

    " VisualSelect and Evaluate inner braces
    nmap <buffer> <F2> vi}<F1>
endi
