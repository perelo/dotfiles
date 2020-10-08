setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
setlocal complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>
setlocal thesaurus=$VIM/thesaurus/fr1.txt
setlocal conceallevel=0

" test without numbers
setlocal nonumber

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
let b:make_clean = "Make clean"

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
	\%Dmake :\ on\ entre\ dans\ le\ répertoire\ « %f »,
	\%Xmake :\ on\ quitte\ le\ répertoire\ « %f »
" TODO remove
setlocal efm^=\%-G%f:%l:\ [Font]\ Font\ shape\ `T1/cmr/bx/scit'\ undefined\ using\ `T1/cmr/bx/sc'\ instead.%.%#
setlocal efm^=\%-G%f:%l:\ [Font]\ Font\ shape\ `T1/cmr/m/scit'\ undefined\ using\ `T1/cmr/m/sc'\ instead.%.%#

if filereadable(expand('%:h').'/Makefile')
  exec "setlocal makeprg=make\\ -C\\ ".expand('%:h')
elseif filereadable($HOME.'/.local/share/latex.mk')
  exec "setlocal makeprg=make\\ -f\\ ~/.local/share/latex.mk\\ -C\\ " . expand("%:h")
endif

let &l:include = '\v\\%(%(input|include|subfile)\{|documentclass\[)\zs\f+\ze%(\}|\]\{subfiles\})'

setlocal foldenable
" setlocal foldlevel=0 " close all folds
let g:tex_fold_ignored_envs = [ 'document' ]

" try to speed things up
" syntax sync maxlines=200
" syntax sync minlines=50
" let g:tex_fast= "bcmM"

" spellcheck everywhere
syntax spell toplevel

setlocal wildignore+=*.aux,*.log,*.bbl,*.blg,*.synctex.gz,*.pdf

" y surround by a command : \command{text}
let b:surround_{char2nr("c")} = "\\\1command: \1{\r}"

nnoremap <silent> <Plug>ChangeSurroundCommand %F\%%cT\
    \:call repeat#set("\<Plug>ChangeSurroundCommand")<CR>
nmap csc <Plug>ChangeSurroundCommand

nnoremap <silent> <Plug>DeleteSurroundCommand %hf}xT{dF\
    \:call repeat#set("\<Plug>DeleteSurroundCommand")<CR>
nmap dsc <Plug>DeleteSurroundCommand

" nnoremap <silent> <Plug>ChangeSurroundEnvironment g_?\\beginf{lct}
"     " \:call repeat#set("\<Plug>ChangeSurroundEnvironment")<CR>
" nmap cse <Plug>ChangeSurroundEnvironment

nnoremap <buffer> <leader>p :call Synctex()<CR>

let &l:define .= '\|\\r\=macromath\s*{'
nnoremap <buffer> <silent> (d     :call FlashOptionSet('isk', '-=', '_')<CR>[d
nnoremap <buffer> <silent> )d     :call FlashOptionSet('isk', '-=', '_')<CR>]d
nnoremap <buffer> <silent> (D     :call FlashOptionSet('isk', '-=', '_')<CR>[D
nnoremap <buffer> <silent> )D     :call FlashOptionSet('isk', '-=', '_')<CR>]D
nnoremap <buffer> <silent> (<C-D> :call FlashOptionSet('isk', '-=', '_')<CR>[<C-D>
nnoremap <buffer> <silent> )<C-D> :call FlashOptionSet('isk', '-=', '_')<CR>]<C-D>
nnoremap <buffer> <silent> <C-W>d :call FlashOptionSet('isk', '-=', '_')<CR><C-W>d
nmap <buffer> <C-W><C-D> <C-W>d

" add ':' to &iskeyword when searching or completing tags
" nnoremap <buffer> <silent> <C-]> :call FlashSet('isk','+=','":,-"')<CR><C-]>
" inoremap <buffer> <silent> <C-]> <C-o>:call Flash('&l:isk', '.=', ',:,-')<CR><C-X><C-]>

nnoremap <buffer> <silent> <C-]> :call FlashOptionSet('isk', '+=', ':,-')<CR><C-]>
inoremap <buffer> <silent> <C-]> <C-o>:call FlashOptionSet('isk', '+=', ':,-')<CR><C-X><C-]>

inoremap <buffer> <c-a> <c-g>u<c-o>I
inoremap <buffer> <c-e> <c-g>u<c-o>A
inoremap <buffer> <c-l> <c-g>u<c-o>/\><CR>
inoremap <buffer> <c-h> <c-g>u<c-o>b

" inoremap <buffer> <C-d> <c-o>d/[\.\$]<CR>
" inoremap <buffer> <C-f> <esc>l/\$<cr>la

" autocorrect last spelling mistake
inoremap <buffer> <C-l> <c-g>u<Esc>[s1z=gi<c-g>u

command! -range=% Toc <line1>,<line2>g/\v\s*\\%(%(sub)*section|chapter|part|appendix|%(front|back|main)matter)>/#
" format fraction <word>/<word> by \frac{word}{word}
command! -buffer -range FracFormat <line1>,<line2>s/\(\k*\)\s*\/\s*\(\k*\)/\\frac\{\1\}\{\2\}/gc

command! BigEq s/\$\(.*\)\$/\r\\[\r  \1\r\\]\r/

if exists('g:loaded_targets')
  augroup TargetDollar
    au!
    autocmd User targets#mappings#user call targets#mappings#extend({
        \ '$': {'quote': [{'d': '\$'}]}
        \ })
  augroup END
endif

" surround word by { } and insert \
" let @s="ysiw}i\\"
