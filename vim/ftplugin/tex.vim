setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
set complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>

setlocal foldenable
" setlocal foldlevel=0 " close all folds

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable(expand('%:h').'/Makefile')
  exec "setlocal makeprg=make\\ -C\\ ".expand('%:h')
else
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif

command! SaveAndMakePdf execute ":silent w | Make" . substitute(expand("%:p"),"tex$","pdf", "")
map <F1> :SaveAndMakePdf<CR>


" nnoremap <leader>s [s1z=<C-o>
