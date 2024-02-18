nnoremap <buffer> <leader>o :call system('xdg-open '.fnameescape(expand('%<').'.html'))<CR>

if expand("%:p") =~ $HOME."/workspace/ue-cloud-tf"
  let b:make = "Make %:p:r".".html"
else
  " don't make, just save. Use e.g. 'grit' for preview
  let b:make = ""
endif
