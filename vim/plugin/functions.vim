" Set the search register '@/' to the last or current visually selected text
function! VSetSearchRegister()
 let temp = @s
 norm! gv"sy
 let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
 let @s = temp
endfunction

" Popup thesaurus as <c-x><c-t> but with space added as a keyword
function! Thesaurus()
    let s:saved_iskeyword = &iskeyword
    let s:saved_updatetime = &updatetime
    if &updatetime > 200 | let &updatetime = 200 | endif
    augroup ThesaurusAuGroup
        autocmd CursorHold,CursorHoldI <buffer>
                    \ let &updatetime = s:saved_updatetime |
                    \ let &iskeyword = s:saved_iskeyword |
                    \ autocmd! ThesaurusAuGroup
    augroup END
    set iskeyword+=32
    return "\<c-x>\<c-t>"
endfunction

" Jump to the next/previous jump which is in a different buffer
function! JumpToNextBufferInJumplist(dir) " 1=forward, -1=backward
    let jl = getjumplist() | let jumplist = jl[0] | let curjump = jl[1]
    let jumpcmdstr = a:dir > 0 ? '<C-O>' : '<C-I>'
    let jumpcmdchr = a:dir > 0 ? '	' : ''    " <C-I> or <C-O>
    let searchrange = a:dir > 0 ? range(curjump+1,len(jumplist))
                              \ : range(curjump-1,0,-1)
    for i in searchrange
        if jumplist[i]["bufnr"] != bufnr('%')
            let n = (i - curjump) * a:dir
            echo "Executing ".jumpcmdstr." ".n." times."
            execute "silent normal! ".n.jumpcmdchr
            break
        endif
    endfor
endfunction

" https://retorque.re/zotero-better-bibtex/cayw/
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'cite' : 'pandoc'
  let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
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

" Echoes the syntax group under the cursor
function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction

" Find and asks to delete active Netrw buffers
function! DeleteNetrwActiveBrowsers()
    let bs = filter(range(1,bufnr('$')), 'getbufvar(v:val, "netrw_browser_active")')
    " for i in range(1, bufnr('$'))
    let delbufs = []
    for i in bs
        let bname = bufname(i)
        let choice = confirm('Delete buffer '.bname, "&Yes\n&No\n&All\n&Quit", 1)
        if choice == 1
            let delbufs += [i]
        elseif choice == 3
            let delbufs += bs[index(bs,i):]
            break
        elseif choice == 4
            return
        endif
    endfor
    if !empty(delbufs)
        exe ":bdelete ".join(delbufs, ' ')
    else
        echo "No netrw buffers to delete."
    endif
endfunction

" Returns the current visually selected text
function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" remove this crap and do something smart with ultisnips
function! InsertMacroGate()
    let macro_name = "__" . substitute(toupper(expand("%:t")), "\\.", "_", "g") . "__"
    execute "normal! i#ifndef " . macro_name
    execute "normal! o#define " . macro_name
    normal! o
    normal! o
    normal! o
    execute "normal! Go#endif /* " . macro_name . " */"
    normal! kk
endfunction
