" Set comma as <leader> instead of default backslash
let mapleader = ","
" reassign ',' motion
noremap ,, ,

" Make Y behave like C and D
nmap Y y$

" pasting in visual don't overwrite @"
xnoremap <expr> p 'pgv"'.v:register.'y'

nmap <Space> .

inoremap œ <Esc>
vnoremap œ <Esc>
onoremap œ <Esc>
cnoremap œ <C-C>

nnoremap Q @q
vmap Q :norm Q<CR>

" Wordwise yank from line above
inoremap <expr> <C-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

xnoremap * :<C-u>call VSetSearchRegister()<CR>/<C-R>/<CR>
xnoremap # :<C-u>call VSetSearchRegister()<CR>?<C-R>/<CR>

" for more, look at tpope/rsi.vim
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

inoremap <expr> <c-h> Thesaurus()

" Drag lines vertically
xnoremap <C-k> xkP`[V`]
xnoremap <C-j> xp`[V`]
xnoremap <C-l> >gv
xnoremap <C-h> <gv

nnoremap <leader>b :ls<CR>:b
nnoremap <leader>o i<CR><ESC>kA
nnoremap <leader>a <C-^>

nnoremap <leader><C-O> :call JumpToNextBufferInJumplist(-1)<CR>
nnoremap <leader><C-I> :call JumpToNextBufferInJumplist( 1)<CR>

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

" missing from unimpaired
nnoremap (oq :copen<CR>
nnoremap )oq :cclose<CR>

nnoremap <leader>rw :%s/\v\s+$//<CR>:w<CR>
nnoremap <leader>h :tab help<space>
nnoremap <leader>dx :redraw!<CR>

nnoremap <leader>vi :edit $MYVIMRC<CR>
nnoremap <leader>rvi :source $MYVIMRC<CR>
nnoremap <leader>rft :exe ':set filetype='.&filetype<CR>

nnoremap <leader>dg :diffget<cr>
nnoremap <leader>dp :diffput<cr>

" see also after/plugin/ctrlp.vim
nnoremap <leader>es :edit $HOME/dotfiles/

" (re)create tag file inside ':pwd'
nnoremap <expr> <leader>sct executable('ctags') ?
                   \ ":!ctags -R .<CR>"         :
                   \ ":echo 'Cannot execute \"ctags\"'<CR>"

command! SaveAndMake execute ":silent w | Make"
nnoremap <F1> :SaveAndMake<CR><Esc>
imap <F1> <Esc><F1>
nnoremap <F5> :Make clean<CR>

" buffer as in hexadecimal editor
nmap <leader>x :%!xxd<CR>
nmap <leader>X :%!xxd -r<CR>

nnoremap <leader>gl :Job xdg-open 'https://tatoeba.org/eng/sentences/search?from=und&to=fra&query=<cword>'<CR>
xnoremap <leader>gl :<c-u>Job xdg-open 'https://tatoeba.org/eng/sentences/search?from=und&to=fra&query=<c-r>=GetVisualSelection()<CR>'<CR>

nnoremap <leader>gw :Xdg 'https://wordreference.com/enfr/<cword>'<CR>

nnoremap <leader>dnw :call DeleteNetrwActiveBrowsers()<CR>

" Move on lines as displayed (when wrapped)
nmap j gj
nmap k gk
nmap 0 g0
nmap $ g$
nmap ^ g^
vmap j gj
vmap k gk
vmap 0 g0
vmap $ g$
vmap ^ g^
