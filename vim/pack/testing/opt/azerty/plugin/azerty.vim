"
" configurations for azerty keyboards
" should be sourced first, e.g. 'source azerty.vim' in .vimrc
"
if exists("g:loaded_azerty") || &compatible
    finish
endif
let g:loaded_azerty = 1

" Remap usefull commands hard to access with azerty
if has('langmap')
    set langmap=é~,è`,ç^,ù%,µ#
    if ! has('nvim')
        set nolangremap     " so that noremap don't take langmap into account
    endif
endif

" Change all [x and ]x mappings to (x and )x
" [a-z], [A-Z], ' ' and chars in :h ] except ( and ) kept for sentence motion
let s:chars  = map(range(65,90) + range(97,122),'nr2char(v:val)')
           \ + [ ' ' ]
           \ + split('<C-D> <C-I> # '' * ` / [ ] {')
for s:c in s:chars
    exec 'nmap ('.s:c.' ['.s:c
    exec 'xmap ('.s:c.' ['.s:c
    exec 'nmap )'.s:c.' ]'.s:c
    exec 'xmap )'.s:c.' ]'.s:c
endfor
" remap sentence motion
nnoremap )) )
nnoremap (( (
xnoremap )) )
xnoremap (( (
