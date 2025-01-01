setlocal sw=4 sts=4 ts=4
setlocal expandtab
" setlocal nolist  " because formatting uses tabs
setlocal iskeyword+=#   " so that Definitions (e.g. #List) are words

setl nolist

let g:cue_fmt_on_save = 0

let cuebin="cue"
let cuecmd="eval"
let cueopt="--simplify"

if exists(':VimuxRunCommand')
    " 'cue eval --simplify ' %:p
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'cue eval --simplify ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'cue eval --simplify ' . expand('%:p')<CR>

    " TODO GetVisualSelection should be escaped
    " cuecmd cuecmd cueopt -
    xnoremap <buffer> <F1> :<C-u>VimuxRunCommand 'echo "'.GetVisualSelection().'" \| '.cuecmd.' eval -'<CR>

    nnoremap <buffer> <F2> :silent w <bar> VimuxRunCommand 'cue export ' . expand("%:p")<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunCommand 'cue export ' . expand('%:p')<CR>

    nnoremap <buffer> <F3> :silent w <bar> VimuxRunCommand 'cue def ' . expand("%:p")<CR>
    inoremap <buffer> <F3> <Esc>:silent w <bar> VimuxRunCommand 'cue def ' . expand('%:p')<CR>

    nnoremap <buffer> <F4> :silent w <bar> call VimuxRunCommand("<C-R>=g:VimuxLastCommand<CR>")
    inoremap <buffer> <F4> <Esc>:silent w <bar> call VimuxRunCommand("<C-R>=g:VimuxLastCommand<CR>")
    nnoremap <buffer> <F4> :silent w <bar> VimuxPromptCommand<CR>
endif
