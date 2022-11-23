
" add scala for arp242/jumpy.vim
" regex buit from https://github.com/derekwyatt/vim-scala/blob/master/ftplugin/scala.vim
call jumpy#map('\v^ *((public|private|private\[\w*\]|protected|abstract|case|override|implicit|final|sealed) )* *(def|class|trait|object)', '')

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" don't compile anything when pressing F1
let b:make=""
" setlocal makeprg=scalac

" Comrade highlight syntaxes
"   highlight link CDEError SpellBad
"   highlight link CDEWarning SpellCap
"   highlight link CDEWeakWarning SpellRare
"   highlight link CDEInfo SpellLocal
hi clear SpellBad
hi SpellBad cterm=undercurl
hi clear SpellCap
hi link SpellCap SpellBad
hi clear Special
hi link Special SpellBad
