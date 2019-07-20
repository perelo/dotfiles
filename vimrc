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
"" My bundles here
""

" original repos on GitHub
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-vinegar'
Bundle 'tpope/vim-eunuch'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tpope/vim-dispatch'
Bundle 'junegunn/vim-easy-align'
Bundle 'ap/vim-buftabline'
Bundle 'itchyny/lightline.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'chriskempson/base16-vim'
Bundle 'wincent/ferret'
Bundle 'matze/vim-tex-fold'
Bundle 'gibiansky/vim-latex-objects'
" Bundle 'ciaranm/securemodelines'

if ! has('nvim')
    packadd matchit
endif

" =============================================================================
" Miscellaneous
" =============================================================================

" Enable filetype detection and load plugin files
filetype plugin on
let $VIM='~/.vim/'

" Set comma as <leader> instead of default backslash
let mapleader = ","
" reassign ',' motion
noremap ,, ,

" Remap usefull commands hard to access with azerty
set langmap=é~,è`,ç^,ù%,µ#
if ! has('nvim')
    set nolangremap     " so that noremap don't take langmap into account
endif

" Use UTF-8 encoding
set encoding=utf-8

" show waiting normal commands
set showcmd


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

" round shift indent to neerest shiftwidth
set shiftround

" Backspace on everything in insert mode
set backspace=indent,eol,start

" Show invisible characters
set list
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

let g:tex_fold_ignored_envs = [ 'document' ]


""
"" Pasting
""

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

set showmode


" =============================================================================
" Appearance
" =============================================================================

syntax on
set number
set scrolloff=2         " Keep more buffer context when scrolling
set visualbell t_vb=    " Remove bip and flash

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif

" Highlight overlength columns
if exists('+colorcolumn')
    set colorcolumn=80
    " highlight OverLength ctermbg=red ctermfg=white
    " exec 'match OverLength /\%'.&cc.'v.\+/'
endif

set laststatus=2        " Always display statusline

hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi link SpellCap SpellBad

function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfunction


" =============================================================================
" Command Line
" =============================================================================

" Remember more commands and search history (default: 20)
set history=100

" Use <Tab> to complete in command line
set wildmenu
set wildmode=full

" Treat numeral numbers as decimal instead of octals (for <C-a> / <C-x>)
set nrformats=

""
"" Search
""

set ignorecase
set smartcase
set nohlsearch
set incsearch

if has('nvim')
    set inccommand=nosplit
endif

" very magic
nnoremap / /\v
nnoremap ? ?\v
cnoremap s/ s/\v

cnoremap <C-A> <Home>
cnoremap <C-E> <End>

" =============================================================================
" Buffers
" =============================================================================

" Allow unsaved background buffers and remember marks/undo for them
set hidden

" Toggle current and alternative buffers
nnoremap <leader>a <C-^>

" Exclude quickfix buffer from `:bnext` `:bprevious`
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" Don't keep netrw buffers, wipe them off if they are hidden
augroup netrw
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufEnter NetrwTreeListing* setlocal filetype=netrw
augroup END

let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3     " tree-style
let g:netrw_hide = 1

function! DeleteNetrwActiveBrowsers()
    let bs = filter(range(1,bufnr('$')), 'getbufvar(v:val, "netrw_browser_active")')
    " for i in range(1, bufnr('$'))
    let delbufs = []
    for i in bs
        let bname = bufname(i)
        let choice = confirm('Delete buffer '.bname, "&Yes\n&No\n&All\n&Quit", 1)
        if choice == 1
            let delbufs += [i]
        elseif choice == 3
            let delbufs += bs[index(bs,i):]
            break
        elseif choice == 4
            return
        endif
    endfor
    if !empty(delbufs)
        exe ":bdelete ".join(delbufs, ' ')
    else
        echo "No netrw buffers to delete."
    endif
endfunction
nnoremap <leader>dnw :call DeleteNetrwActiveBrowsers()<CR>


" =============================================================================
" Windows
" =============================================================================

" Split windows below and right instead of above and left
set splitbelow splitright


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

autocmd BufNewFile *.tex 0r $HOME/.vim/tex_header.txt
autocmd BufNewFile *.tex exe "/title"

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
"" Buftabline
""

let g:buftabline_indicators=1   " show '+' when buf is modified
let g:buftabline_numbers=1      " internal buffers numbers

""
"" CtrlP
""

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_cmd = 'CtrlPMRU'


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
xnoremap (e [egv
xnoremap )e ]egv

""
"" Easy-Align
""

" Enter interactive mode
vnoremap <leader>a :EasyAlign<CR>
" Align in command-line
vnoremap <leader>A :EasyAlign


""
"" UltiSnips
""

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsEditSplit="context"

let g:UltiSnipsSnippetDir=$HOME.'/.vim/UltiSnips/'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips/', $HOME.'/.vim/bundle/vim-snippets/UltiSnips']

""
"" ferret
""

" Instead of <leader>a used for 'alternative file'
nmap <leader>f <Plug>(FerretAck)

"
" tags
"

" search for 'tags' file up the working tree until it finds one
set tags+=./tags;

" (re)create tag file inside ':pwd'
nnoremap <expr> <leader>sct executable('ctags') ?
                   \ ":!ctags -R .<CR>"         :
                   \ ":echo 'Cannot execute \"ctags\"'<CR>"


" =============================================================================
" General mapping
" =============================================================================

" Make Y behave like C and D
nmap Y y$

nnoremap <Space> .

inoremap œ <Esc>
" vnoremap œ <Esc>
" onoremap œ <Esc>
" cnoremap œ <Esc>

nnoremap Q @q
vmap Q :norm Q<CR>

" missing from unimpaired
map (oq :copen<CR>
map )oq :cclose<CR>

" Wordwise yank from line above
inoremap <expr> <C-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" Drag lines vertically
xnoremap <C-k> xkP`[V`]
xnoremap <C-j> xp`[V`]
xnoremap <C-l> >gv
xnoremap <C-h> <gv

noremap <leader>rw :%s/\v\s+$//<CR>:w<CR>
noremap <leader>h :tab help<space>
nnoremap <leader>dx :redraw!<CR>
nnoremap <leader>b :ls<CR>:b

noremap <leader>vi :edit $MYVIMRC<CR>
noremap <leader>rvi :source $MYVIMRC<CR>
noremap <leader>rft :exe ':set filetype='.&filetype<CR>

" cut line here and insert
noremap <leader>o i<CR><ESC>kA

command! SaveAndMake execute ":silent w | Make"
nnoremap <F1> :SaveAndMake<CR><Esc>
imap <F1> <Esc><F1>
nnoremap <F5> :Make clean<CR>

" write as sudo
command! W execute 'silent! write !sudo tee % > /dev/null' | silent! edit!

" buffer as in hexadecimal editor
nmap <leader>x :%!xxd<CR>
nmap <leader>X :%!xxd -r<CR>

" https://retorque.re/zotero-better-bibtex/cayw/
function! ZoteroCite()
  " pick a format based on the filetype (customize at will)
  let format = &filetype =~ '.*tex' ? 'cite' : 'pandoc'
  let api_call = 'http://localhost:23119/better-bibtex/cayw?format='.format.'&brackets=1'
  let ref = system('curl -s '.shellescape(api_call))
  return ref
endfunction

noremap <leader>z "=ZoteroCite()<CR>p
inoremap <C-z> <C-r>=ZoteroCite()<CR>

" synctex used with zatura
" vimura must be in the $PATH, maybe set shellcmdflags to interactive :
"set shellcmdflag=-ic
function! Synctex()
    let vimura_param = " --synctex-forward " . line('.') . ":" . col('.') . ":" . expand('%:p') . " " . substitute(expand('%:p'),"tex$","pdf", "")
    if has('nvim')
        call jobstart("vimura neovim" . vimura_param)
    else
        " remove 'silent' for debugging
        exe "silent !vimura vim" . vimura_param . "&"
    endif
    redraw!
endfunction
map <leader>p :call Synctex()<CR>


function! JumpToNextBufferInJumplist(dir) " 1=forward, -1=backward
    let jl = getjumplist() | let jumplist = jl[0] | let curjump = jl[1]
    let jumpcmdstr = a:dir > 0 ? '<C-O>' : '<C-I>'
    let jumpcmdchr = a:dir > 0 ? '	' : ''    " <C-I> or <C-O>
    let searchrange = a:dir > 0 ? range(curjump+1,len(jumplist))
                              \ : range(curjump-1,0,-1)
    for i in searchrange
        if jumplist[i]["bufnr"] != bufnr('%')
            let n = (i - curjump) * a:dir
            echo "Executing ".jumpcmdstr." ".n." times."
            execute "silent normal! ".n.jumpcmdchr
            break
        endif
    endfor
endfunction
nnoremap <leader><C-O> :call JumpToNextBufferInJumplist(-1)<CR>
nnoremap <leader><C-I> :call JumpToNextBufferInJumplist( 1)<CR>

" =============================================================================
" Fixes
" =============================================================================

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
