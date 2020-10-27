"
" see functions.vim for some function definitions
"
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

command! -nargs=+ -complete=customlist,CompleteNetrwListed DeleteNetrw bd <args>

command! SynGroup call SynGroup()

" keep the cursor in the current buffer after :cwindow and :lwindow
command! -bang CWindow cwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif
command! -bang LWindow lwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif

" buffer as in hexadecimal editor
command! XXD %!xxd
command! XXDReverse %!xxd -r
