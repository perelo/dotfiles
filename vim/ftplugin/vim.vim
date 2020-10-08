setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

nnoremap <buffer> <F1> :<c-u>write <bar> source %<CR>
inoremap <buffer> <F1> <Esc>:write <bar> source %<CR>
nnoremap <buffer> <F2> :<c-u>write <bar> execute getline('.')<CR>
inoremap <buffer> <F2> <Esc>:write <bar> execute getline('.')<CR>
set iskeyword-=#
