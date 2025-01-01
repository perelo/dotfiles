"
" show statements with missing terminal dot
" g/[^\.]$/v/mod\|end[fm]/v/^\s*---\|\*\*\*/

setl commentstring=---\ %s

let maude_dir=split(system('whereis maude'), ':')[1]
if len(maude_dir) > 0
    let &path.=fnamemodify(maude_dir, ':h')
endif

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'in '.expand('%').' .'<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'in ' . expand('%').' .'<CR>

    " nnoremap <buffer> <F2> :silent w <bar> VimuxRunLastCommand<CR>
    " inoremap <buffer> <F2> <Esc>:silent w <bar> VimuxRunLastCommand<CR>
endif
