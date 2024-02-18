setl ts=2 sts=2 sw=2
setl expandtab

let b:make='!dot -Tpng %:p -O'

" overload ../plugin/xdg.vim
nnoremap <buffer> <leader>p :call system('xdg-open '.fnameescape(expand('%:p').'.png'))<CR>
