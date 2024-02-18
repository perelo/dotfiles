
"
" Add mappings to optionally (with '?') show registers before using them.
" Do so by intercepting commands as '"'.
"
inoremap <c-r>? <c-r>="\<lt>c-r>" . <SID>BetterRegister('register')<cr>
cnoremap <c-r>? <c-r>="\<lt>c-r>" . <SID>BetterRegister('register')<cr>
nnoremap <expr> "? '"' . <SID>BetterRegister('register')
xnoremap <expr> "? '"' . <SID>BetterRegister('register')
nnoremap <expr> @? '@' . <SID>BetterRegister('register')

nnoremap <expr> '? "'" . <SID>BetterRegister('mark')
nnoremap <expr> `? '`' . <SID>BetterRegister('mark')

function! <SID>BetterRegister(what)
   let more = &more
   set nomore
   redraw!
   execute a:what.'s'
   echohl Question | echon "\nPlease press the ".a:what." name" | echohl None
   let &more = more
   while 1
       let ch = getchar()
       if ch !~# '\v[0-9]+'
           continue
       else
           redraw!
           return nr2char(ch)
       endif
   endwhile
endfunction


" From
" https://www.reddit.com/r/vim/comments/1ap2s64/repost_from_nvim_sharing_some_coolimo_reg/
function! CycleReg()
    " make delete behaviour of having the registers 1-9 cycle the values of all
    " the previous deletes, work *also* on yank
    if v:event.operator == 'y' && v:event.regname == ''
        let @9 = @8
        let @8 = @7
        let @7 = @6
        let @6 = @5
        let @5 = @4
        let @4 = @3
        let @3 = @2
        let @2 = @1
        let @1 = @0
    endif
endfunction
autocmd TextYankPost * call CycleReg()
