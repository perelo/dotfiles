setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2

setlocal errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
if !filereadable('Makefile') && !filereadable('makefile')
    setlocal makeprg=javac\ %
endif
