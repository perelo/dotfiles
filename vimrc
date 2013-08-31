execute pathogen#infect()
execute pathogen#helptags()
set nocompatible

filetype plugin on
syntax on
set encoding=utf-8
set autoindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set number
set visualbell t_vb=    " remove bip and flash
set laststatus=2        " always display statusline

map <F8> :source $MYVIMRC<CR>
map <F7> :tabedit $MYVIMRC<CR>

let mapleader = ","

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch
nmap <silent> <leader><leader> :nohlsearch<CR>

" pasting
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

set foldmethod=syntax
set foldlevelstart=99   " all folds open at start

" highlight overlength columns
if exists('+colorcolumn')
    set colorcolumn=81
    highlight OverLength ctermbg=red ctermfg=white
    exec 'match OverLength /\%'.&cc.'v.\+/'
endif

" show trailing whitespaces and tabs
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" moving lines
nnoremap <A-down> :m+<CR>==
nnoremap <A-up> :m-2<CR>==
inoremap <A-down> <Esc>:m+<CR>==gi
inoremap <A-up> <Esc>:m-2<CR>==gi
vnoremap <A-down> :m'>+<CR>gv=gv
vnoremap <A-up> :m-2<CR>gv=gv

" moving around windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" make Y behave like C and D
nmap Y y$

" move on lines as displayed
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

" coloring
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

set splitbelow
set splitright

" set commentstring for Python files (vim-commentary plugin)
autocmd FileType python set commentstring=#\ %s

" insert header comments on C/C++ and Python files
autocmd BufNewFile *.py so $HOME/.vim/py_header.txt
autocmd BufNewFile *.py exe "% s/\\(.*author.*\\)/\\1 '" .$USER ."'"
autocmd BufNewFile *.py exe "% s/\\(.*date.*\\)/\\1 '" .strftime("%d-%m-%Y") ."'"
autocmd BufNewFile *.py exe "normal! G"
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} so $HOME/.vim/c_header.txt
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([fF]ile\\)/\\1 " .expand("%")
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([aA]uthor\\)/\\1 " .$USER
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([dD]ate\\)/\\1 " .strftime("%d-%m-%Y")
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "normal! G"

function! s:insert_macro_gate()
    let macro_name = "__" . substitute(toupper(expand("%:t")), "\\.", "_", "g") . "__"
    execute "normal! i#ifndef " . macro_name
    execute "normal! o#define " . macro_name
    normal! o
    normal! o
    normal! o
    execute "normal! Go#endif /* " . macro_name . " */"
    normal! kk
endfunction
" insert macro gate
autocmd BufNewFile *.{h,hpp,hxx} call <SID>insert_macro_gate()
autocmd BufNewFile *.{c,cpp,cxx} exe "normal! o"
