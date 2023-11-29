setlocal ts=2 sts=2 sw=2

setlocal spell
setlocal colorcolumn=0
setlocal commentstring=//\ %s

let b:make = "Make %:p:r".".html"
nnoremap <leader>o :call system('xdg-open '.fnameescape(expand('%<').'.html'))<CR>

" https://github.com/asciidoctor/asciidoctor/issues/3414
setlocal errorformat=asciidoctor:\ ERROR:\ %f:\ line\ %l:\ %m

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi link SpellCap SpellBad
