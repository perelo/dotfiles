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
    let l:pos = matchstrpos(l:line, l:opt_marks_pat.'\%'.(col('.')+1).'c')
    return pos[0] != '' ?
                \ matchstr(l:line, l:or_marks_pat.'\zs\k\+', l:pos[1]) :
                \ expand('<cword>')
endfunction

function! TagRequest() abort
    let l:cword = expand('<cword>')
    if taglist(l:cword) == []
        call system('ctags -R .')
    endif
    try
        execute 'tag '.l:cword
    catch
        echohl WarningMsg
        echo matchstr(v:exception, '^Vim\%((\a\+)\)\=:\zs.*')
        echohl None
        return
    endtry
endfunction

function! TeXFold(lnum)
    let line = getline(a:lnum)
    if line =~ '^\\chapter'
        return '>1'
    endif
    if line =~ '^\\section'
        return '>2'
    endif
    if line =~ '^\\subsection'
        return '>3'
    endif
    if line =~ '^\\subsubsection'
        return '>4'
    endif

    " Environments
    let l:ignored_envs = [ 'document', 'cases' ]
    let l:ignore_envs_pat = '\%(' . join(l:ignored_envs, '\|') . '}\)\@!'
    if line =~ '^[^%]*\\begin{' . l:ignore_envs_pat
        return 'a1'
    endif
    if line =~ '^[^%]*\\end{' . l:ignore_envs_pat
        return 's1'
    endif

    " markers
    if line =~ '^[^%]*%[^{]*{{{'
        return 'a1'
    endif
    if line =~ '^[^%]*%[^}]*}}}'
        return 's1'
    endif

    " commented paragraphs
    if line =~ '^\s*%'
      if getline(a:lnum-1) !~ '^\s*%'
        return 'a1'
      endif
      if getline(a:lnum+1) !~ '\s*%'
        return 's1'
      endif
    endif

    return '='
endfunction
