"
" see functions.vim for some function definitions
"
" write as sudo
command! W execute 'silent! write !sudo tee % > /dev/null' | silent! edit!

" execute asynchronous job
command! -nargs=1 Job execute ':silent !'.<q-args> | execute ':redraw!'

command! -nargs=* -range -complete=buffer -bar -bang BD
  \ <line1>,<line2>call BDelete('<range>', '<bang>', <f-args>)

cabbrev bd BD

command! -nargs=+ -complete=customlist,CompleteNetrwListed DeleteNetrw bd <args>

command! SynGroup call SynGroup()

" keep the cursor in the current buffer after :cwindow and :lwindow
command! -bang CWindow cwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif
command! -bang LWindow lwindow |
      \ if '<bang>' == '!' && &ft == 'qf' | wincmd p | endif
