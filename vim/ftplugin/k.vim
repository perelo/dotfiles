setl ft=2
setl sts=2
setl sw=2
setl expandtab
setl colorcolumn=0

setl path-=/usr/include
setl path+=/usr/include/kframework/builtin

let &l:include = '^\s*requires "\zs[^"]*\ze"'
setl iskeyword+=-

let &l:define = '^\s*\(syntax\|module\)'
setl isident+=-

" voir ~/.vim/compiler/k.vim
