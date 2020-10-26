
if !exists('g:loaded_bbye') || g:loaded_bbye == 0
  finish
endif

command! -bang -complete=buffer -nargs=? Bdelete 
