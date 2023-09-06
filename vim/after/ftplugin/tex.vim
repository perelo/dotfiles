setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal textwidth=79
setlocal spell
" setlocal complete+=s " search also in 'thesaurus' file when <C-n>/<C-p>
setlocal thesaurus=$VIM/thesaurus/fr1.txt
setlocal conceallevel=0
setlocal wildignore+=*.aux,*.log,*.bbl,*.blg,*.synctex.gz,*.pdf
setlocal iskeyword+=-       " composed-words
setlocal suffixesadd+=.cls

setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=TeXFold(v:lnum) " see $VIM/plugin/functions.vim
setlocal foldopen-=block          " don't open fold on }-like commands
" setlocal foldlevelstart=2         " fold sections on start

" test without numbers
" setlocal nonumber

syntax spell toplevel             " spellcheck everywhere

" set 'include' and 'define' options
let &l:include = '\v\\%(%(input|include|subfile)\{'
let &l:include .= '\v|documentclass\[)\zs\f+\ze%(\}|\]\{subfiles\})'
let &l:define .= '\|\\r\=macromath\s*{'

" {{{ FlashOptionSet for tags and definitions
"
" add ':', '-' and '_' when looking for tags
let s:tmaps = '<C-]>, <C-LeftMouse>, g<LeftMouse>,'   " jump to found tag
let s:tmaps.= 'g<C-]>,'                               " :tjump
let s:tmaps.= 'g],'                                   " :tselect
let s:tmaps.= '<C-W><C-]>, <C-W>],'                   " :stag
let s:tmaps.= '<C-W>g<C-]>,'                          " :stjump
let s:tmaps.= '<C-W>g],'                              " :stselect
let s:tmaps.= '<C-W>}, <C-W>g}'                       " :ptag and :ptjump
for s:lhs in split(s:tmaps, ',')
  let lhs = trim(s:lhs)
  execute "nnoremap <buffer> <silent> " . lhs
          \ . " :call FlashOptionSet('isk','+=',':,-,_')<CR>" . lhs
endfor
inoremap <buffer> <silent> <C-]>
          \ <C-o>:call FlashOptionSet('isk','+=',':,-,_')<CR><C-X><C-]>

" remove '_' when looking for definitions
let s:dmaps = '[d, ]d, [D, ]D, [<C-D>, ]<C-D>, <C-W>d, <C-W><C-D>'
for s:lhs in split(s:dmaps, ',')
  let lhs = trim(s:lhs)
  execute "nnoremap <buffer> <silent> " . lhs
          \ . " :call FlashOptionSet('isk','-=','_')<CR>" . lhs
endfor
" }}}

xnoremap <buffer> g$ $?\S<CR>

nnoremap <buffer> <leader>p :call Synctex()<CR>

inoremap <buffer> <c-a> <c-g>u<c-o>I
inoremap <buffer> <c-e> <c-g>u<c-o>A
inoremap <buffer> <c-l> <c-g>u<c-o>/\><CR>
inoremap <buffer> <c-h> <c-g>u<c-o>b

" inoremap <buffer> <C-d> <c-o>d/[\.\$]<CR>
" inoremap <buffer> <C-f> <esc>l/\$<cr>la

" autocorrect last spelling mistake
inoremap <buffer> <C-l> <c-g>u<Esc>[s1z=gi<c-g>u

" {{{ Surround
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
" }}}

" {{{ Commands
command! -range=% Toc <line1>,<line2>g/\v\s*\\%(%(sub)*section|chapter|part|appendix|%(front|back|main)matter)>/#
"
" format fraction <word>/<word> by \frac{word}{word}
command! -buffer -range FracFormat <line1>,<line2>s/\(\k*\)\s*\/\s*\(\k*\)/\\frac\{\1\}\{\2\}/gc

command! BigEq s/\$\(.*\)\$/\r\\[\r  \1\r\\]\r/
" }}}


" {{{ Compilation

" classical compilation
let b:tex_flavor = 'pdflatex'
setlocal makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
setlocal errorformat=%f:%l:\ %m

" used in <F1> mapping, see $VIM/plugin/mappings.vim
let b:make = "Make %:t:r".".pdf"
let b:make_clean = "Make clean"

let &l:makeprg = "make"
if filereadable(expand('%:p:h').'/Makefile')
  " there is a Makefile in the current buffer's directory
  " pass it to the -f option of 'make' in case there is also one in the cwd
  let &l:makeprg .= " -f " . expand('%:p:h') . '/Makefile'
  " let b:make = "Make"   " Make it simple
elseif filereadable($HOME.'/.local/share/latex.mk')
  " use global latex.mk
  let &l:makeprg .= " -f ".$HOME."/.local/share/latex.mk"
endif
let &l:makeprg .= " -C ".expand('%:h')       " compile in the buffer's directory

setlocal errorformat=%f:%l:\ %m,%f:%l-%\\d%\\+:\ %m,
	\%Dmake :\ on\ entre\ dans\ le\ répertoire\ « %f »,
	\%Xmake :\ on\ quitte\ le\ répertoire\ « %f »
" setlocal efm^=\%-G%f:%l:\ [Font]\ Font\ shape\ `T1/cmr/bx/scit'\ undefined\ using\ `T1/cmr/bx/sc'\ instead.%.%#


" }}} Compilation

" {{{ syntaxes
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi link SpellCap SpellBad

hi link texOnlyMath Normal
" Prevent hi group texOnlyMath link to Error
let b:tex_stylish = 1
" }}}


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
"
" append \left and \right to \{ and \}
" s?\ze\\}?\\right?g | s?\ze\\{?\\left?g
"
" vim: set foldmethod=marker
