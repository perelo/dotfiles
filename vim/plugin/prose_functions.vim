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
function! TagFromOutside()
    let li = getline('.') | let col = col('.')
    let tag_regex = '\v\\(ref|cite)\{(\k+)\}'
    let tag_pos = [ "" , 0 , 0 ]
    while tag_pos != [ "", -1, -1 ]
        let tag_pos = matchstrpos(li, tag_regex, tag_pos[2])
        if tag_pos[1]+1 > col       " if start of match overrun cursor, break
            break
        elseif tag_pos[2] >= col    " tag found
            return substitute(tag_pos[0], tag_regex, '\2', '')
        endif
    endwhile
    return expand('<cword>')
endfunction
