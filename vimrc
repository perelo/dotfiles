" =============================================================================
" Initialization
" =============================================================================

" Clear autocmds
autocmd!

" Use Vim settings, rather than Vi
set nocompatible

""
"" Vundle
""

filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

""
"" My bundles here:
""

" original repos on GitHub
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-eunuch'
Bundle 'itchyny/lightline.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'junegunn/vim-easy-align'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'fholgado/minibufexpl.vim'

""
"" Miscellaneous
""

" Enable file type detection and load plugin indent files
filetype plugin on

" Set comma as <leader> instead of default backslash
let mapleader = ","

" Use UTF-8 encoding
set encoding=utf-8


" =============================================================================
" Editing
" =============================================================================

""
"" Whitespace
""

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

" Backspace on everything in insert mode
set backspace=indent,eol,start

" Show invisible characters
set list

" Invisible characters
set listchars=tab:>.,trail:.,extends:#,nbsp:.


""
"" Wrapping
""

set wrap " Enable wrapping

" Move on lines as displayed
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


""
"" Folding
""

set foldmethod=syntax
set foldlevelstart=99   " All folds open at start


""
"" Pasting
""

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

set showmode


""
"" Spelling
""

nmap <silent> <leader>spl :set spell!<CR>
set spelllang=fr


" =============================================================================
" Appearance
" =============================================================================

syntax on
set number
set scrolloff=2         " Keep more buffer context when scrolling
set visualbell t_vb=    " Remove bip and flash
set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1

" Toggle numbers / relative numbers
nmap <silent> <C-n> :exec 'set number!' &number ? 'relativenumber!' : ''<CR>

" Highlight overlength columns
if exists('+colorcolumn')
    set colorcolumn=80
    " highlight OverLength ctermbg=red ctermfg=white
    " exec 'match OverLength /\%'.&cc.'v.\+/'
endif

set laststatus=2        " Always display statusline


" =============================================================================
" Command Line
" =============================================================================

" Remember more commands and search history (default: 20)
set history=100

" Expand %% to current directory (http://vimcasts.org/e/14)
cnoremap %% <C-R>=expand('%:h').'/'<cr>


""
"" Search
""

set ignorecase
set smartcase
set hlsearch
set incsearch
nmap <silent> <leader>n :nohlsearch<CR>


" =============================================================================
" Buffers
" =============================================================================

" Allow unsaved background buffers and remember marks/undo for them
set hidden

" Toggle current and alternative buffers
nnoremap <leader>a <C-^>


" =============================================================================
" Windows
" =============================================================================

" Split windows below and right instead of above and left
set splitbelow splitright

" Move around splits with <c-hjkl>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" =============================================================================
" Registers
" =============================================================================

" Paste and fix indentation
nmap <leader>p p=']


" =============================================================================
" Filetypes and Custom Autocmds
" =============================================================================

" Make sure all markdown files have the correct filetype
autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown

" Tex files must be 'tex' filetype not 'plaintex'
autocmd BufRead,BufNewFile *.{tex} set filetype=tex

" Set commentstring for Python files (vim-commentary plugin)
autocmd FileType python set commentstring=#\ %s

""
"" Headers
""

autocmd BufNewFile *.py so $HOME/.vim/py_header.txt
autocmd BufNewFile *.py exe "% s/\\(.*author.*\\)/\\1 '" .$USER ."'"
autocmd BufNewFile *.py exe "% s/\\(.*date.*\\)/\\1 '" .strftime("%d-%m-%Y") ."'"
autocmd BufNewFile *.py exe "normal! G"

autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} so $HOME/.vim/c_header.txt
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([fF]ile\\)/\\1 " .expand("%")
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([aA]uthor\\)/\\1 " .$USER
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([dD]ate\\)/\\1 " .strftime("%d-%m-%Y")
autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "normal! G"

autocmd BufNewFile *.hs so $HOME/.vim/hs_header.txt
autocmd BufNewFile *.hs exe "% s/\\([fF]ile\\)/\\1 " .expand("%")
autocmd BufNewFile *.hs exe "% s/\\([aA]uthor\\)/\\1 " .$USER
autocmd BufNewFile *.hs exe "% s/\\([dD]ate\\)/\\1 " .strftime("%d-%m-%Y")
autocmd BufNewFile *.hs exe "normal! G"

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
" Insert macro gate
autocmd BufNewFile *.{h,hpp,hxx} call <SID>insert_macro_gate()
autocmd BufNewFile *.{c,cpp,cxx} exe "normal! o"


" =============================================================================
" Plugin Settings and Mappings
" =============================================================================

""
"" Unimpaired
""

" Change all [ ] mappings to ( ) for unimpaired plugin (thanks to tpope)
for s:c in map(range(32,33) + range(65,90) + range(97,122),'nr2char(v:val)')
  exec 'nmap ('.s:c.' ['.s:c
  exec 'xmap ('.s:c.' ['.s:c
  exec 'nmap )'.s:c.' ]'.s:c
  exec 'xmap )'.s:c.' ]'.s:c
endfor
xmap (e [egv
xmap )e ]egv


""
"" Easy-Align
""

" Enter interactive mode
vnoremap <leader>a :EasyAlign<CR>
" Align in command-line
vnoremap <leader>A :EasyAlign


""
"" MinBufExplorer
""

map <silent> <leader>b :MBEToggle<CR>
let g:miniBufExplBRSplit = 0


""
"" General mapping
""

nnoremap <CR> G
nnoremap <BS> gg

" Make Y behave like C and D
nmap Y y$

" Drag lines much easier than (e and )e w/ unimpaired
vnoremap <C-k> xkP`[V`]
vnoremap <C-j> xp`[V`]
vnoremap <C-h> <gv
vnoremap <C-l> >gv

map <leader>rw :%s/\s\+$//<CR>:w<CR>
map <leader>vi :edit $MYVIMRC<CR>
map <leader>rvi :source $MYVIMRC<CR>
map <leader>m :make<CR>
map <leader>h :tab help 

" switch current word w/ the one right after
map <leader>inv yiwWvep#vep

nnoremap <space> .

nnoremap Q @q

" Wordwise yank from line above
inoremap <expr> <C-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
