setlocal ts=2 sts=2 sw=2

setlocal spell
setlocal colorcolumn=0
setlocal commentstring=//\ %s

" https://github.com/asciidoctor/asciidoctor/issues/3414
setlocal errorformat=asciidoctor:\ ERROR:\ %f:\ line\ %l:\ %m
setlocal makeprg=asciidoctor

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi link SpellCap SpellBad

nnoremap <leader>o :call system('xdg-open '.fnameescape(expand('%<').'.html'))<CR>


" if exists(':VimuxRunCommand')
"     " 'cue eval --simplify ' %:p
"     nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'asciidoctor ' . expand("%:p")<CR>
"     inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'asciidoctor ' . expand('%:p')<CR>
" endif
