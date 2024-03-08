
" Eatchar used to eat trailing space, see `helpgrep Eatchar`
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

cnoreabbrev eft edit ~/.vim/{after/,after/ft,ft}plugin/*<c-r>=&filetype<cr>*.vim<c-d><c-r>=Eatchar(" ")<cr>

" TODO remove duplicate in ~/.vimrc/
let s:my_dirs = {
      \ 'h - here dir'   : "'%:p:h'",
      \ 'p - path (pwd)' : "'.'",
      \ 'gi - git root'  : "GitRootDir('%')",
      \ 'go - go module' : "GoRootDir('%')",
      \ 'd - dotfiles'   : "'$HOME/dotfiles'",
      \ 'w - workspace'  : "'$HOME/workspace'",
      \ 'v - vimfiles'   : "'$VIM'",
      \ 'r - runtime'    : "'$VIMRUNTIME'",
      \ }

"
" :edit $dir <c-d> from directories in s:my_dirs, see $HOME/.vimrc
for [dirname, dir] in items(s:my_dirs)
  let abbrev = split(dirname)[0]
  exe 'cnoreabbrev e' . abbrev . ' ' .
    \ 'edit <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
  " cnoreabbrev eh e <c-r>=expand('%:h')<cr>/<c-d><c-r>=Eatchar('\s')<cr>
endfor
" same as `%` mapping in netrw
cabbrev ee edit <c-r>=expand('%:p')<cr><c-r>=Eatchar('\s')<cr>

"
" :saveas $dir %[] <c-d>
for [dirname, dir] in items(s:my_dirs)
  let abbrev = split(dirname)[0]
  exe 'cnoreabbrev sa' . abbrev . ' ' .
    \ 'saveas <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
endfor
cabbrev sas saveas <c-r>=expand('%:p')<cr><c-r>=Eatchar('\s')<cr>

"
" :Grep $dir
for [dirname, dir] in items(s:my_dirs)
  let abbrev = split(dirname)[0]
  exe 'cnoreabbrev grep' . abbrev . ' ' .
    \ 'Grep <c-r>=expand(' . dir . ')<cr>/<c-d><c-r>=Eatchar(" ")<cr>'
endfor

" (re)create tag file inside ':pwd' or in the current file's directory
cabbrev sct !ctags -R

iabbrev teh the
