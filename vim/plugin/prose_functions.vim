" https://retorque.re/zotero-better-bibtex/cayw/
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'cite' : 'pandoc'
  let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

" synctex used with zatura
" vimura must be in the $PATH, maybe set shellcmdflags to interactive :
"set shellcmdflag=-ic
function! Synctex()
    let vimura_param = " --synctex-forward " . line('.') . ":" . col('.') . ":" . expand('%:p') . " " . substitute(expand('%:p'),"tex$","pdf", "")
    if has('nvim')
        call jobstart("vimura neovim" . vimura_param)
    else
        " remove 'silent' for debugging
        exe "silent !vimura vim" . vimura_param . "&"
    endif
    redraw!
endfunction

" go to tag if cursor is anywhere on '\ref{...}' or '\cite{...}'
function! NextWordFromInside(marks)
    let l:line          = getline('.')
    let l:or_marks_pat  = '\%('.join(a:marks,'\|').'\)'
    let l:opt_marks_pat = '\%(\%['.join(a:marks,']\|\%[').']\)'
    " echo l:or_marks_pat . ' ' . l:opt_marks_pat
    let l:pos = matchstrpos(l:line, l:opt_marks_pat.'\%'.(col('.')+1).'c')
    return pos[0] != '' ?
                \ matchstr(l:line, l:or_marks_pat.'\zs\k\+', l:pos[1]) :
                \ expand('<cword>')
endfunction
