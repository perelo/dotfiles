
function! MyCompleteFileName()
    " match a (potential) wildcard preceding cursor position
    " note: \f is a filename character, see :h 'isfname'
    let l:pattern = matchstr(strpart(getline('.'), 0, col('.') - 1), '\v(\f|\*|\?)*$')
    " set the matches 
    call complete(col('.') - len(l:pattern), globpath("../", '*', 0, 1))
    " must return an empty string to show the menu
    return ''
endfunction


" rebind <C-X><C-F> to invoke our custom function
" inoremap <C-X><C-G> <C-R>=MyCompleteFileName()<CR>
