setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
setlocal spelllang=fr

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable('Makefile')
  setlocal makeprg=make
else
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ " . substitute(expand("%:p"),"tex$","pdf", "") . "\\ -C\\ " . expand("%:h")
endif
