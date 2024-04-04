setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

if exists(':VimuxRunCommand')
  nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'cat '.expand('%:p').' \| yq "."'<CR>
endif
