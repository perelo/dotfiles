if ! executable('xdg-open')
    finish
endif

nnoremap <leader>o :call system('xdg-open '.fnameescape(expand('%')))<CR>
nnoremap <leader>p :call system('xdg-open '.fnameescape(expand('%<').'.pdf'))<CR>

" autocmd FileType markdown \
"   nnoremap <leader>p :!firefox %.html

nnoremap <leader>gl :call system('xdg-open "https://tatoeba.org/eng/sentences/search?from=und&to=fra&query='.expand('<cword>').'"')<CR>
xnoremap <leader>gl :<c-u>call system('xdg-open "https://tatoeba.org/eng/sentences/search?from=und&to=fra&query=<c-r>=GetVisualSelection()<CR>"')<CR>

nnoremap <leader>gw :call system('xdg-open "https://wordreference.com/enfr/'.expand('<cword>').'"')<CR>

