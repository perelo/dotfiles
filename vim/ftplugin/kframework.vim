setl ts=2
setl sw=2
setl sts=2
setl expandtab

let &l:include = '^\s*requires\s\+"\zs\f\+\ze"'
setl iskeyword+=-

setl path-=/usr/include
setl path+=/usr/include/kframework/builtin

let &l:define  = '^\s*module'
let &l:define .= '\|^\s*syntax[^=]*=\s*\ze\i\+\s*([^\[]*\[.*function'
let &l:define .= '\|^\s*syntax'
setl isident+=-

setl makeprg=kompile
if exists("g:loaded_dispatch")
  let b:cmd = "Dispatch kompile %"
endif

nnoremap <F1> :silent w <bar> execute b:cmd<CR><Esc>
inoremap <F1> <Esc>:silent w <bar> execute b:cmd<CR><Esc>
