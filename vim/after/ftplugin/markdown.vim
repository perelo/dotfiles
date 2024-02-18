

setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal textwidth=0  " keep long lines when inserting
setlocal wrap " long lines visible
setlocal colorcolumn=0
setlocal showbreak=↼⇥               " 2 char
setlocal modeline

setlocal spell
setlocal spelllang=en,fr

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap           " osef des majuscules

" composed-words are words
setlocal iskeyword+=-

setlocal conceallevel=2

setlocal foldnestmax=4

" allow inserting comment leader when pressing o O
setlocal formatoptions+=o

" don't map anything
let g:vim_markdown_no_default_key_mappings = 1
" disable folds because foldlevel is local to *window*
" let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_folding_level = &foldlevel
" include foldtext in the title
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_follow_anchor = 1
" don't try to autoindent nested item
let g:vim_markdown_new_list_item_indent = 2
" stop inserting bullet points when formatting (wrapping) w/ gq or gw
let g:vim_markdown_auto_insert_bullets = 0
" remove 'gf', 'gx', ',xi' mappings
let g:pandoc#hypertext#use_default_mappings = 0


if expand("%:p") =~ $HOME."/workspace/ue-cloud-tf/"
  let b:make = "Make %:t:r".".html"
else
  " don't make, just save. Use e.g. 'grit' for preview
  let b:make = ""
endif
