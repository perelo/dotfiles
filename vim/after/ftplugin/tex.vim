setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
setlocal complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>
setlocal thesaurus=$VIM/thesaurus/fr1.txt
setlocal conceallevel=0

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi link SpellCap SpellBad
" Prevent hi group texOnlyMath link to Error
let b:tex_stylish = 1

" classical compilation
let b:tex_flavor = 'pdflatex'
setlocal makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
setlocal errorformat=%f:%l:\ %m

" compiler maketex

" used in <F1> mapping, see $VIM/plugin/mappings.vim
let b:make = "Make %:t:r".".pdf"
" let b:make = "Make ".expand('%:p:r').'.pdf'

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
	\%Dmake :\ on\ entre\ dans\ le\ répertoire\ « %f »,
	\%Xmake :\ on\ quitte\ le\ répertoire\ « %f »

if filereadable(expand('%:h').'/Makefile')
  exec "setlocal makeprg=make\\ -C\\ ".expand('%:h')
elseif filereadable($HOME.'/.local/share/latex.mk')
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif


setlocal foldenable
" setlocal foldlevel=0 " close all folds
let g:tex_fold_ignored_envs = [ 'document' ]

" nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'pdflatex '.expand('%')<CR>
" inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'pdflatex '.expand('%')<CR>

" try to speed things up
syntax sync maxlines=200
syntax sync minlines=50
let g:tex_fast= "bcmM"

" spellcheck everywhere
syntax spell toplevel

setlocal wildignore+=*.aux,*.log,*.bbl,*.blg,*.synctex.gz,*.pdf

" surround by a command : \command{text}
let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"

nnoremap <buffer> <leader>p :call Synctex()<CR>

let &l:define .= '\|\\r\=macromath\s*{'
nnoremap <buffer> (d     :call FlashOptionSet('isk', '-=', '_')<CR>[d
nnoremap <buffer> )d     :call FlashOptionSet('isk', '-=', '_')<CR>]d
nnoremap <buffer> (D     :call FlashOptionSet('isk', '-=', '_')<CR>[D
nnoremap <buffer> )D     :call FlashOptionSet('isk', '-=', '_')<CR>]D
nnoremap <buffer> (<C-D> :call FlashOptionSet('isk', '-=', '_')<CR>[<C-D>
nnoremap <buffer> )<C-D> :call FlashOptionSet('isk', '-=', '_')<CR>]<C-D>
nnoremap <buffer> <C-W>d :call FlashOptionSet('isk', '-=', '_')<CR><C-W>d
nmap <buffer> <C-W><C-D> <C-W>d

inoremap <buffer> <c-a> <c-g>u<c-o>I
inoremap <buffer> <c-e> <c-g>u<c-o>A
inoremap <buffer> <c-l> <c-g>u<c-o>/\><CR>
inoremap <buffer> <c-h> <c-g>u<c-o>b

" add ':' and '-' as keywords, mostly for \ref{...} matching
setlocal iskeyword+=:
setlocal iskeyword+=-

" nnoremap <buffer> <silent> <C-]> :call TagRequest()<CR>
" nnoremap <buffer> <silent> <C-]> :execute
"             \ 'tag '.NextWordFromInside(['\\ref{', '\\cite{'])<CR>

inoremap <buffer> <C-d> <c-o>d/[\.\$]<CR>
inoremap <buffer> <C-f> <esc>l/\$<cr>la

" inoremap <buffer> <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
command! -range=% Toc <line1>,<line2>g/\v\s*\\%(%(sub)*section|chapter|part|appendix|%(front|back|main)matter)>/#
" format fraction <word>/<word> by \frac{word}{word}
command! -buffer -range FracFormat <line1>,<line2>s/\(\k*\)\s*\/\s*\(\k*\)/\\frac\{\1\}\{\2\}/gc

command! BigEq s/\$\(.*\)\$/\r\\[\r  \1\r\\]\r/

" surround word by { } and insert \
" let @s="ysiw}i\\"
