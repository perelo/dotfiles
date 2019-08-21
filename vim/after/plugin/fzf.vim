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

nnoremap <leader>ee :execute (g:in_git_repo ? 'G' : '').'Files '.expand('%:p:h')<CR>
nnoremap <leader>ep :execute (g:in_git_repo ? 'G' : '').'Files '<CR>
nnoremap <leader>er :Files $VIMRUNTIME<CR>
nnoremap <leader>eb :Buffer<CR>
nnoremap <leader>et :Tags<CR>
nnoremap <leader>eh :History<CR>
nnoremap <leader>e: :History:<CR>
nnoremap <leader>ed :Files $HOME/dotfiles<CR>
nnoremap <leader>ew :Files $HOME/workspace<CR>

" override <leader>hh in plugin/mappings.vim
nnoremap <leader>hh :Helptags<CR>

" spell replacement with <leader>z=
function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction
function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap <leader>z= :call FzfSpell()<CR>

imap <c-f> <plug>(fzf-complete-file)
