setl ft=2
setl sts=2
setl sw=2
setl expandtab
setl colorcolumn=0

setl include="^\s*requires"
setl define="^\s*syntax"  " TODO add module
setl iskeyword+=-

setl path-=/usr/include
setl path+=/usr/include/kframework/builtin

" voir ~/.vim/compiler/k.vim
