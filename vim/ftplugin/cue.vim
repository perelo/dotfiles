setlocal nolist  " because formatting uses tabs
setlocal iskeyword+=#   " so that Definitions (e.g. #List) are words

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> call VimuxRunCommandInDir('cue eval '.expand('%:t'), 0)<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> call VimuxRunCommandInDir('cue eval '.expand('%:t'), 0)<CR>
    nnoremap <buffer> <F2> :silent w <bar> VimuxRunLastCommand<CR>
    inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>
    nnoremap <buffer> <F4> :silent w <bar> VimuxPromptCommand<CR>
endif
