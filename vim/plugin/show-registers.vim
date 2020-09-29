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
