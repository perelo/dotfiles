" Vim compiler file
" Compiler:             make TeX

if exists("current_compiler")
  finish
endif
let current_compiler = 'maketex'

let s:cpo_save = &cpo
set cpo&vim

" used in <F1> mapping, see $VIM/plugin/mappings.vim
let g:make = "Make ".expand('%:p:r').'.pdf'

CompilerSet errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
	\%Dmake :\ on\ entre\ dans\ le\ répertoire\ « %f »,
	\%Xmake :\ on\ quitte\ le\ répertoire\ « %f »

if filereadable(expand('%:h').'/Makefile')
  exec "CompilerSet makeprg=make\\ -C\\ ".expand('%:h')
elseif filereadable($HOME.'/.local/share/latex.mk')
  exec "CompilerSet makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif


let &cpo = s:cpo_save
unlet s:cpo_save
