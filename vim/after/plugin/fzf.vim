if !exists('g:loaded_fzf') || g:loaded_fzf == 0
    finish
endif

let g:fzf_layout = { 'down': '40%' }

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }

" if update, also check ../../plugin/mappings.vim and ../../plugin/grep.vim
nnoremap <leader>ee :execute 'Files <C-R>=expand('%:p')<CR>'<CR>
nnoremap <leader>eh :execute 'Files <C-R>=expand('%:p:h')<CR>'<CR>
nnoremap <leader>ep :execute 'Files <C-R>=getcwd()<CR>'<CR>
nnoremap <leader>eg :call fzf#vim#gitfiles('', {'dir' : GitRootDir('%')})<CR>
nnoremap <leader>ed :Files $HOME/dotfiles<CR>
nnoremap <leader>er :Files $VIMRUNTIME<CR>

nnoremap <leader>ew :Files $HOME/workspace<CR>

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
