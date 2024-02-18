if !exists('g:loaded_fzf') || g:loaded_fzf == 0
    finish
endif

"
" See ~/.vim/plugin/abbrev.vim for mappings like <leader>eh
"

let g:fzf_layout = { 'down': '40%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }


" remap <leader>eg to GFiles on the right root
nnoremap <leader>eg :call fzf#vim#gitfiles('', {'dir' : GitRootDir('%')})<CR>

" add other fzf mappings <!> override on the dirs_to_search loop above
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
