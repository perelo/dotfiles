"
" For Maude syntax, see ~/.vim/bundle/maude.vim/syntax/maude.vim

setl commentstring=----\ %s

setl iskeyword+=-

setl suffixesadd=.maude
let &l:include = '^\s*load\s\+\zs\f\+'
setl includeexpr=v:fname.'.maude'

let &l:define  = '\v^\s*(op|var|sort)\s+'
let &l:define .= '|^\s*(ops|vars|sorts)\s+(\w+\s+)*' " work with `gd` but not `[d`

let maude_dir=split(system('whereis maude'), ':')[1]
if len(maude_dir) > 0
    let &path.=fnamemodify(maude_dir, ':h')
endif

" show statements with missing terminal dot
let @d='g/[^\.]$/v/mod\|end[fm]/v/^\s*---\|\*\*\*/vimgrep .'

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'load '.expand('%:p').' .'<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'load ' . expand('%:p').' .'<CR>

    " nnoremap <buffer> <F2> :silent w <bar> VimuxRunLastCommand<CR>
    " inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>
endif
