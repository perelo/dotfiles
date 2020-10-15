" write as sudo
command! W execute 'silent! write !sudo tee % > /dev/null' | silent! edit!

" execute asynchronous job
command! -nargs=1 Job execute ':silent !'.<q-args> | execute ':redraw!'

" delete buffer and keep window splits
function! BDelete(bang, ...)
    if a:0 == 0
        exe 'bprev'.a:bang
        exe 'bdelete'.a:bang.' #'
    else
        exe 'bdelete'.a:bang.' '.join(a:000,' ')
    endif
endfunction

command! -complete=buffer -bar -bang -nargs=* BD call BDelete('<bang>', <f-args>)
cabbrev bd BD

command! SynGroup call SynGroup()
