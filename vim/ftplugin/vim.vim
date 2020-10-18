setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal foldmethod=marker

nnoremap <buffer> <F1> :<c-u>write <bar> source %<CR>
inoremap <buffer> <F1> <Esc>:write <bar> source %<CR>
nnoremap <buffer> <F2> :<c-u>execute join(getline(line("."),line(".")+v:count),"\|")<CR>
inoremap <buffer> <F2> <Esc>:execute getline('.')<CR>
xnoremap <buffer> <F2> <Esc>:execute join(getline(line("'<"),line("'>")),"\|")<CR>
set iskeyword-=#
