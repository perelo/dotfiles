
" prepare editing file in the directory of current file
" Eatchar used to eat trailing space, see `helpgrep Eatchar`
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

" TODO remove duplicate in ~/.vimrc/
let s:my_dirs = {
      \ 'h - here dir'   : "'%:p:h'",
      \ 'p - path (pwd)' : "'.'",
      \ 'g - gitdir'     : "GitRootDir('%')",
      \ 'd - dotfiles'   : "'$HOME/dotfiles'",
      \ 'w - workspace'  : "'$HOME/workspace'",
      \ 'v - vimfiles'   : "'$VIM'",
      \ 'r - runtime'    : "'$VIMRUNTIME'",
      \ }

"
" :edit $dir <c-d> from directories in s:my_dirs, see $HOME/.vimrc
let s:dirname2char = map(copy(s:my_dirs), 'v:key[0]')
for [dirname, dir] in items(s:my_dirs)
  exe 'cnoreabbrev e' . s:dirname2char[dirname] . ' ' .
    \ 'edit <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
  " cnoreabbrev eh e <c-r>=expand('%:h')<cr>/<c-d><c-r>=Eatchar('\s')<cr>
endfor
" same as `%` mapping in netrw
cabbrev ee edit <c-r>=expand('%:p')<cr><c-r>=Eatchar('\s')<cr>

"
" :saveas $dir %[] <c-d>
let s:dirname2char = map(copy(s:my_dirs), 'v:key[0]')
for [dirname, dir] in items(s:my_dirs)
  exe 'cnoreabbrev sa' . s:dirname2char[dirname] . ' ' .
    \ 'saveas <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
endfor
cabbrev sas saveas <c-r>=expand('%:p')<cr><c-r>=Eatchar('\s')<cr>


"
" :Grep $dir
let s:dirname2char = map(copy(s:my_dirs), 'v:key[0]')
for [dirname, dir] in items(s:my_dirs)
  exe 'cnoreabbrev grep' . s:dirname2char[dirname] . ' ' .
    \ 'Grep <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
endfor

" (re)create tag file inside ':pwd' or in the current file's directory
cabbrev sct !ctags -R

iabbrev teh the
