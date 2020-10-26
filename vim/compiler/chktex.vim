" Vim compiler file
" Compiler:             ChkTeX

if exists("current_compiler")
  finish
endif
let current_compiler = 'chktex'

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=chktex\ -v0
CompilerSet errorformat=%f:%l:%c:%n:%m,

let &cpo = s:cpo_save
unlet s:cpo_save
