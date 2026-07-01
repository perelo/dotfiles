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
command! -bar -bang CWindow cwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif
command! -bar -bang LWindow lwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif

" buffer as in hexadecimal editor
command! XXD %!xxd
command! XXDReverse %!xxd -r

command! -range=% CUEToMaude
            \  <line1>,<line2>s/\a\+/'&/ge
            \| <line1>,<line2>s/\v'(int|bool)/\1/ge
            \| <line1>,<line2>s/_/top/ge
            \| <line1>,<line2>s/:/ :/ge
            \| <line1>,<line2>s/\./ . /ge
command! -range=% MaudeToCUE
            \  <line1>,<line2>s/top/_/ge
            \| <line1>,<line2>s/v(\([^)]*\))/\1/ge
            \| <line1>,<line2>s/'//ge
            \| <line1>,<line2>s/ :/:/ge
            \| <line1>,<line2>s/ \. /./ge

command! -range=% MdToTex
            \  <line1>,<line2>s/_\([^_]*\)_/\\emph{\1}/ge
            \| <line1>,<line2>s/`\([^`]*\)`/\\texttt{\1}/ge
            \| <line1>,<line2>s/\v\[\@?([^\]]*)\]/\\cite{\1}/ge
            \| <line1>,<line2>s/\*/\\item/ge
command! -range=% TexToMd
            \  <line1>,<line2>s/\\emph{\([^}]*\)}/_\1_/ge
            \| <line1>,<line2>s/\\texttt{\([^}]*\)}/`\1`/ge
            \| <line1>,<line2>s/\\cite{\([^}]*\)}/[@\1]/ge
            \| <line1>,<line2>s/\\item/*/ge
