" {{{ Commons

" Use UTF-8 encoding
set encoding=utf-8

" show current 'insert', 'normal' or 'visual' mode
set showmode

" Allow unsaved background buffers and remember marks/undo for them
set hidden

" Backspace on everything in insert mode
set backspace=indent,eol,start

" searching
set incsearch
set ignorecase
set smartcase
set nohlsearch
if has('nvim')
    set inccommand=nosplit
endif

" Whitespaces
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround          " round shift indent to neerest shiftwidth
set softtabstop=4
set autoindent

" show waiting normal commands
set showcmd

" number column
set number

" Show invisible characters
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" default windows split below and right instead of above and left
set splitbelow splitright

" scrolling
set scrolloff=2         " Keep more buffer context when scrolling
set sidescrolloff=1     " Scroll immediatly on the side on last column
set visualbell t_vb=    " Remove bip and flash

" accept mouse
set mouse=nvchr

" automatically update buffer if changed, warn if unsaved changes
set autoread

" Folding
set foldmethod=indent
set foldignore=         " default is '#' for C code
set foldlevelstart=99   " All folds open at start

set pastetoggle=<F2>

" Remember more commands and search history (default: 20)
set history=100

" Use <Tab> to complete in command line
set wildmenu
set wildmode=full

" search for 'tags' file up the working tree until it finds one
set tags+=./tags;

" Treat numeral numbers as decimal instead of octals (for <C-a> / <C-x>)
set nrformats=

" Delete comment character when joining commented lines with J and gJ
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" don't add two spaces when joining lines ending witih '.', '!' and '?'
set nojoinspaces

" netrw buffers
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3     " tree-style
let g:netrw_hide = 1

" }}}
" {{{ Displays

" Always display statusline
set laststatus=2

" Enable line wrapping
set wrap

" Highlight overlength columns
if exists('+colorcolumn')
    set colorcolumn=80
    " highlight OverLength ctermbg=red ctermfg=white
    " exec 'match OverLength /\%'.&cc.'v.\+/'
endif

" }}}
" {{{ Saving

" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and
" updatetime (4 seconds) are fine
set swapfile
execute 'set directory^='.expand('$VIM/swap//')

" persist the undo tree for each file
if has('persistent_undo')
    set undofile
    execute 'set undodir^='.expand('$VIM/undo//')
endif

" }}}

" vim: set fdm=marker
