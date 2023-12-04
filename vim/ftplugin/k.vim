setl ts=2
setl sw=2
setl sts=2
setl expandtab

setl path-=/usr/include
setl path+=/usr/include/kframework/builtin

setl makeprg=kompile
if exists("g:loaded_dispatch")
  let b:cmd = "Dispatch (cd %:h; kompile %:t)"
  let b:cmdd = "Dispatch (cd %:h; kompile %:t --enable-llvm-debug)"
endif

nnoremap <buffer> <F1> :silent w <bar> execute b:cmd<CR><Esc>
inoremap <buffer> <F1> <Esc>:silent w <bar> execute b:cmd<CR><Esc>
nnoremap <buffer> <F2> :silent w <bar> execute b:cmdd<CR><Esc>
inoremap <buffer> <F2> <Esc>:silent w <bar> execute b:cmdd<CR><Esc>
