setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
set complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>

setlocal foldenable
" setlocal foldlevel=0 " close all folds

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m
if filereadable(expand('%:h').'/Makefile')
  exec "setlocal makeprg=make\\ -C\\ ".expand('%:h')
else
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif

command! SaveAndMakePdf execute ":silent w | Make" . substitute(expand("%:p"),"tex$","pdf", "")
map <F1> :SaveAndMakePdf<CR>


" add ':' and '-' as keywords, mostly for \ref{...} matching
setlocal iskeyword+=:
setlocal iskeyword+=-

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
nnoremap <silent> <C-]> :execute 'tag '.TagFromOutside()<CR>

" nnoremap <leader>s [s1z=<C-o>
