let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_cmd = 'CtrlPMRU'

if exists(':CtrlP')
    nnoremap <leader>es :CtrlP $HOME/dotfiles<CR>
    nnoremap <leader>eb :CtrlPBuffer<CR>
    nnoremap <leader>et :CtrlPTag<CR>
endi
