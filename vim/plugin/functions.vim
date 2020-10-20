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

function! IsInGitRepo()
    call system('git rev-parse --git-dir > /dev/null 2>&1')
    return v:shell_error == 0
endfunction

function! GitRootDir(...) abort
    let l:path = a:0 ? a:000[0] : '.'
    let l:oldcwd = getcwd()
    execute "cd " . l:path
    let l:rootdir = system('git rev-parse --show-toplevel')
    execute "cd " . l:oldcwd
    if v:shell_error != 0
        return ''
    endif
    return l:rootdir
endfunction

" function! RegenerateTags() abort
"     echo 'Regenerating tags...'
"     let l:dir = GitRootDir()
"     if l:dir == ''
"         let l:dir = expand('%:p')
"     endif
"     call system('ctags -R '.l:dir)
"     echo 'Done regenerating tags!'
" endfunction


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

" Set the search register '@/' to the last or current visually selected text
function! VSetSearchReg()
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" highlight last searched until CursorMoved
function! HLNext()
  let l:higroup = matchend(getline('.'), '\c'.@/, col('.')-1) == col('.')
              \ ? 'SpellRare' : 'IncSearch'
  let b:match_id = matchadd(l:higroup, '\c\%#'.@/, 101)
  redraw
  augroup HLNext
    autocmd CursorMoved <buffer> ++once
                \   execute 'silent! call matchdelete('.b:match_id.')'
                \ | redraw
  augroup END
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

function! Thesaurus32()
    if has('timers') && !empty(&thesaurus)
        call timer_start(20, {_->execute('set iskeyword-=32')})
        set iskeyword+=32
    endif
    return "\<c-x>\<c-t>"
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
