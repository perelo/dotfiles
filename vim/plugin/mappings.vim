"
" General mappings
"
" Other specific general mappings can be found in the files bellow {{{
" to regenerate :
" read !ag -l --ignore={'bundle/','mappings.vim'} -G .vim$ '^\s*[nvxsoilct]?(nore)?map\s+(<(?\!buffer)[^>]+>\s*)*[^<\s]' $HOME/.vim
"
" /home/eloi/.vim/plugin/PP.vim
" /home/eloi/.vim/plugin/inchlsearch.vim
" /home/eloi/.vim/plugin/ccr.vim
" /home/eloi/.vim/plugin/show-registers.vim
" /home/eloi/.vim/plugin/grep.vim
" /home/eloi/.vim/plugin/gitignore.vim
" /home/eloi/.vim/plugin/xdg.vim
" /home/eloi/.vim/plugin/ctrlx.vim
" /home/eloi/.vim/plugin/cmdline_completion.vim
" /home/eloi/.vim/after/plugin/easyalign.vim
" /home/eloi/.vim/after/plugin/slime.vim
" /home/eloi/.vim/after/plugin/qf.vim
" /home/eloi/.vim/after/plugin/fzf.vim
" /home/eloi/.vim/after/ftplugin/tex.vim
" /home/eloi/.vim/pack/testing/opt/azerty/plugin/azerty.vim
" /home/eloi/.vim/ftplugin/qf.vim
"
"
" Some <buffer> mappings can be found in the files bellow
" to regenerate :
" read !ag -l --ignore={'bundle/','mappings.vim'} -G .vim$ '^\s*[nvxsoilct]?(nore)?map .*<buffer>' $HOME/.vim
"
" /home/eloi/.vim/after/ftplugin/python.vim
" /home/eloi/.vim/after/ftplugin/tex.vim
" /home/eloi/.vim/ftplugin/python_ipdb.vim
" /home/eloi/.vim/ftplugin/vim.vim
" /home/eloi/.vim/ftplugin/c.vim
" /home/eloi/.vim/ftplugin/qf.vim
" /home/eloi/.vim/autoload/plug.vim
" }}}


" Make Y behave like C and D
nmap Y y$

" pasting in visual don't overwrite @"
xnoremap <expr> p 'pgv"'.v:register.'y'

nmap <Space> .
xmap <Space> :norm .<CR>

" see also autocmds.vim /cr_bs
nnoremap <CR> za
nnoremap <silent> <BS> :<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>

" resize splits more easily
nnoremap + <C-w>+
nnoremap _ <C-w>-

" Get out more easily
inoremap œ <Esc>
vnoremap œ <Esc>
onoremap œ <Esc>
cnoremap œ <C-C>
" /!\ watchout when writing things like 'dijkstra'
inoremap jk <ESC>
inoremap kj <Esc>

nnoremap Q @q
vmap Q :norm Q<CR>

" Wordwise yank from line above
inoremap <expr> <C-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

xnoremap <silent> * :<C-u>call VSetSearchReg()<CR>/<C-R>/<CR>:call HLNext()<CR>
xnoremap <silent> # :<C-u>call VSetSearchReg()<CR>?<C-R>/<CR>:call HLNext()<CR>

nnoremap <silent> * *:call HLNext()<CR>
nnoremap <silent> g* g*:call HLNext()<CR>
nnoremap <silent> # #:call HLNext()<CR>
nnoremap <silent> g# g#:call HLNext()<CR>
nnoremap <silent> n n:call HLNext()<CR>
nnoremap <silent> N N:call HLNext()<CR>

" for more, look at tpope/rsi.vim
cnoremap <C-E> <End>

" go _to_ paragraph (1 line less)
xnoremap g} :<c-u>call cursor(line("'}")-empty(getline(line("'}"))),col("'>") )<CR>`<gv``
xnoremap g{ :<c-u>call cursor(line("'{")+empty(getline(line("'{"))),col("'<") )<CR>`>gv``
nnoremap g} :<c-u>call cursor(line("'}")-empty(getline(line("'}"))),col(".") )<CR>
nnoremap g{ :<c-u>call cursor(line("'{")+empty(getline(line("'{"))),col(".") )<CR>

nnoremap <leader>b :call RunCommandWithOption("&more", "0", "ls")<CR>:b<Space>
nnoremap <leader>a :<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>

nnoremap <leader><C-O> :call JumpToNextBufferInJumplist(-1)<CR>
nnoremap <leader><C-I> :call JumpToNextBufferInJumplist( 1)<CR>

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

nnoremap <leader>rw :%s/\v\s+$//<CR>:w<CR>
nnoremap <leader>dx :redraw!<CR>

nnoremap <leader>hv :vertical help<Space>
nnoremap <leader>ht :tab help<Space>
nnoremap <leader>hg :helpgrep<space>

nnoremap <leader>vi :edit $MYVIMRC<CR>
nnoremap <leader>rvi :source $MYVIMRC<CR>
nnoremap <leader>rft :exe ':set filetype='.&filetype<CR>
nnoremap <leader>dft :filetype detect<CR>

if has('+diff')
    nnoremap <leader>dg :diffget<cr>
    nnoremap <leader>dp :diffput<cr>
endif

" open file from directories in g:my_dirs, see $HOME/.vimrc
let s:dirs_to_search = copy(g:my_dirs)
call remove(s:dirs_to_search, 'buffer')  " % is not a directory, use <leader>p
let s:dirname2char = map(copy(s:dirs_to_search), 'v:key[0]')
for [dirname, dir] in items(s:dirs_to_search)
  exe 'nnoremap <leader>e' . s:dirname2char[dirname] . ' ' .
    \ ':<c-u>edit <C-R>=expand(' . dir . ')<CR>/<C-D>'
endfor

" (re)create tag file inside ':pwd' or in the current file's directory
cabbrev sct !ctags -R

let b:make = "Make %"
let b:make_clean = "Make clean"
nnoremap <F1> :silent w <bar> execute b:make<CR><Esc>
inoremap <F1> <Esc>:silent w <bar> execute b:make<CR><Esc>
nnoremap <F5> :execute b:make_clean<CR><Esc>

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

" vim: set foldlevel=0
