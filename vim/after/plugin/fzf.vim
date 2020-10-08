if !exists('g:loaded_fzf') || g:loaded_fzf == 0
    finish
endif

let g:in_git_repo = IsInGitRepo()
if exists("##DirChanged")
    augroup UpdateGitRepoVariable
        au!
        autocmd DirChanged * let g:in_git_repo = IsInGitRepo()
    augroup END
endif

" if update, also check mappings.vim
nnoremap <leader>ee :execute 'Files <C-R>=expand('%:p:h')<CR>'<CR>
nnoremap <leader>ep :execute 'Files <C-R>=getcwd()<CR>'<CR>
nnoremap <leader>eg :execute (g:in_git_repo ? 'G' : '').'Files '<CR>
nnoremap <leader>ed :Files $HOME/dotfiles<CR>
nnoremap <leader>ew :Files $HOME/workspace<CR>

nnoremap <leader>er :Files $VIMRUNTIME<CR>
nnoremap <leader>eb :Buffer<CR>
nnoremap <leader>et :Tags<CR>
nnoremap <leader>eh :History<CR>
nnoremap <leader>e: :History:<CR>

" override <leader>hh in plugin/mappings.vim
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
