" exchange :cfirst and :cpfile mappings and use parenthesis (for azerty)
nnoremap )Q :cnfile<CR>
nnoremap (Q :cpfile<CR>
nnoremap )<C-Q> :clast<CR>
nnoremap (<C-Q> :cfirst<CR>

" same for location list
nnoremap )L :lnfile<CR>
nnoremap (L :lpfile<CR>
nnoremap )<C-L> :llast<CR>
nnoremap (<C-L> :lfirst<CR>

" open and close quickfix
nnoremap (oq :copen<CR>
nnoremap )oq :cclose<CR>

" open and close location list, lose 'list' option toogle
nnoremap (ol :lopen<CR>
nnoremap )ol :lclose<CR>
