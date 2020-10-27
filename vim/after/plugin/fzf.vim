if !exists('g:loaded_fzf') || g:loaded_fzf == 0
    finish
endif

let g:fzf_layout = { 'down': '40%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }


" open file from directories in g:my_dirs, see $HOME/.vimrc
" it should reflect $HOME/.vim/plugin/mappings.vim <leader>e mappings
let s:dirs_to_search = copy(g:my_dirs)
call remove(s:dirs_to_search, 'buffer')  " % is not a directory, use <leader>p
let s:dirname2char = map(copy(s:dirs_to_search), 'v:key[0]')
for [dirname, dir] in items(s:dirs_to_search)
  exe 'nnoremap <leader>e' . s:dirname2char[dirname] . ' ' .
    \ ':<c-u>Files <C-R>=' . dir . '<CR><CR>'
endfor

" remap <leader>eg to GFiles on the right root
nnoremap <leader>eg :call fzf#vim#gitfiles('', {'dir' : GitRootDir('%')})<CR>

nnoremap <leader>eb :Buffer<CR>
nnoremap <leader>eo :History<CR>

nnoremap <leader>et :Tags<CR>
nnoremap <leader>e: :History:<CR>
nnoremap <leader>hh :Helptags<CR>

" " spell replacement with <leader>z=
" function! FzfSpellSink(word)
"   exe 'normal! "_ciw'.a:word
" endfunction
" function! FzfSpell()
"   let suggestions = spellsuggest(expand("<cword>"))
"   return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
" endfunction
" nnoremap <leader>z= :call FzfSpell()<CR>
