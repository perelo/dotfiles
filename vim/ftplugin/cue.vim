setlocal nolist  " because formatting uses tabs
setlocal iskeyword+=#   " so that Definitions (e.g. #List) are words

let b:cuecmd="cue"

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand b:cuecmd.' eval '.expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand b:cuecmd.' eval '.expand('%:p')<CR>

    " TODO GetVisualSelection should be escaped
    xnoremap <buffer> <F1> :<C-u>VimuxRunCommand 'echo "'.GetVisualSelection().'" \| '.b:cuecmd.' eval -'<CR>

    nnoremap <buffer> <F2> :silent w <bar> VimuxRunLastCommand<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>

    nnoremap <buffer> <F3> :silent w <bar> call VimuxRunCommand("<C-R>=g:VimuxLastCommand<CR>")
    inoremap <buffer> <F3> <Esc>:silent w <bar> call VimuxRunCommand("<C-R>=g:VimuxLastCommand<CR>")
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>
    nnoremap <buffer> <F4> :silent w <bar> VimuxPromptCommand<CR>
endif
