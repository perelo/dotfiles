

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal textwidth=0  " keep long lines when inserting
setlocal wrap " long lines visible
setlocal colorcolumn=0
setlocal showbreak=↼⇥               " 2 char
setlocal modeline

setlocal spell
setlocal spelllang=en,fr

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap           " osef des majuscules

" composed-words are words
setlocal iskeyword+=-

setlocal conceallevel=2

setlocal foldnestmax=4

" allow inserting comment leader when pressing o O
setlocal formatoptions+=o

if expand("%:p") =~ $HOME."/workspace/ue-cloud-tf/"
  let b:make = "Make %:t:r".".html"
else
  " don't make, just save. Use e.g. 'grit' for preview
  let b:make = ""
endif
