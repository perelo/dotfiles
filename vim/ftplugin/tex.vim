setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
setlocal complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>
setlocal thesaurus=$VIM/thesaurus/fr1.txt

setlocal foldenable
" setlocal foldlevel=0 " close all folds
let g:tex_fold_ignored_envs = [ 'document' ]

" try to speed things up
syntax sync maxlines=200
syntax sync minlines=50
let g:tex_fast= "bcmM"

" spellcheck everywhere
syntax spell toplevel

setlocal wildignore+=*.aux,*.log,*.bbl,*.blg,*.synctex.gz,*.pdf

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
setlocal errorformat+=%Dmake :\ on\ entre\ dans\ le\ répertoire\ « %f »
setlocal errorformat+=%Xmake :\ on\ quitte\ le\ répertoire\ « %f »

if filereadable(expand('%:h').'/Makefile')
  exec "setlocal makeprg=make\\ -C\\ ".expand('%:h')
elseif filereadable($HOME.'/.local/share/latex.mk')
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif

command! SaveAndMakePdf execute ":silent w | Make" . substitute(expand("%:p"),"tex$","pdf", "")
nnoremap <buffer> <F1> :SaveAndMakePdf<CR>

map <leader>p :call Synctex()<CR>

" add ':' and '-' as keywords, mostly for \ref{...} matching
setlocal iskeyword+=:
setlocal iskeyword+=-

nnoremap <buffer> <silent> <C-]> :execute 'tag '.TagFromOutside()<CR>

inoremap <buffer> <C-d> <c-o>d/[\.\$]<CR>
inoremap <buffer> <C-f> <esc>l/\$<cr>la

inoremap <buffer> <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" format fraction <word>/<word> by \frac{word}{word}
command! -buffer -range FracFormat <line1>,<line2>s/\(\k*\)\s*\/\s*\(\k*\)/\\frac\{\1\}\{\2\}/gc

" surround word by { } and insert \
let @s="ysiw}i\\"
