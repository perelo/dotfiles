" write as sudo
command! W execute 'silent! write !sudo tee % > /dev/null' | silent! edit!

" execute asynchronous job
command! -nargs=1 Job execute ':silent !'.<q-args> | execute ':redraw!'
