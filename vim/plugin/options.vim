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
set ignorecase
set smartcase

if has('extra_search')
    set incsearch
    set nohlsearch
endif
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
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
set listchars=tab:‣·,trail:·,extends:…,nbsp:·

set fillchars=vert:\|,fold:\ 

" default windows split below and right instead of above and left
set splitbelow splitright

" scrolling
set scrolloff=2         " Keep more buffer context when scrolling
set sidescrolloff=1     " Scroll immediatly on the side on last column
set visualbell t_vb=    " Remove bip and flash

" accept mouse
if has('mouse')
    set mouse=nvchr
endif

" automatically update buffer if changed, warn if unsaved changes
set autoread

" Folding
if has('folding')
    set foldmethod=indent
    set foldignore=         " default is '#' for C code
    set foldlevelstart=99   " All folds open at start
endif

set pastetoggle=<F2>

" Remember more commands and search history (default: 20)
if has('cmdline_hist')
    set history=100
endif

" Use <Tab> to complete in command line
if has('wildmenu')
    set wildmenu
endif
set wildmode=longest:full,full
set wildignorecase

" search for 'tags' file up the working tree until it finds one
if has('path_extra')
    set tags+=./tags;
endif

" get confirm dialog when :q :e ... fails
set confirm

" Treat numeral numbers as decimal instead of octals (for <C-a> / <C-x>)
set nrformats=

" Delete comment character when joining commented lines with J and gJ
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif
" pressing <Enter> in insert mode while writing a comment continue commenting
set formatoptions+=r

set completeopt=menu,menuone,preview
if has('popupwin')
  set completeopt+=popup
  set previewpopup=height:10,width:60
  set completepopup=height:10,width:60
endif

" don't add two spaces when joining lines ending witih '.', '!' and '?'
set nojoinspaces

" don't wait terminal-key-codes, specially usefull when <Esc>
if !has('gui_running')
    set ttimeoutlen=10
endif

set timeoutlen=4000

" keep cursor on the same column after <C-d>,<C-u>, G, H, L, gg, etc.
set nostartofline

" netrw buffers
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 1     " like ls
let g:netrw_hide = 1
let g:netrw_altfile = 1       " keep the alternate buffer !

" }}}
" {{{ Displays

" Enable line wrapping
set wrap

if has('linebreak')
  set showbreak=↪               " put this at the start of wrapped lines
  set breakindent               " wrap are indented as the line wrapped
  " set linebreak                 " wrap words
endif


" Highlight overlength columns
if exists('+colorcolumn')
    set colorcolumn=80
    " highlight OverLength ctermbg=red ctermfg=white
    " exec 'match OverLength /\%'.&cc.'v.\+/'
endif

if has('cursorshape')
    let &t_SI = "\<esc>[5 q"    " | cursor in insert mode
    let &t_SR = "\<esc>[5 q"    " | cursor in replace mode
    let &t_EI = "\<esc>[2 q"    " bloc cursor when back to normal
endif

" modify other key
let &t_TI = "\<Esc>[>4;2m"
let &t_TE = "\<Esc>[>4;m"

" }}}
" {{{ Saving, source takes ~3ms for each next paragraph

if exists('$SUDO_USER')
    set noswapfile                      " don't create root-owned files
else
    execute 'set directory^='.expand('$VIM/tmp/swap//')
    set swapfile
endif

" persist the undo tree for each file
if has('persistent_undo')
    if exists('$SUDO_USER')
        set noundofile                    " don't create root-owned files
    else
        execute 'set undodir^='.expand('$VIM/tmp/undo//')
        set undofile
    endif
endif

" }}}

" vim: fdm=marker
