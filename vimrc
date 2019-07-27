" =============================================================================
" Initialization
" =============================================================================

" Clear autocmds
autocmd!

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
Bundle 'wellle/targets.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'mbbill/undotree'
Bundle 'chriskempson/base16-vim'
Bundle 'wincent/ferret'
Bundle 'matze/vim-tex-fold'
Bundle 'gibiansky/vim-latex-objects'
Bundle 'perelo/thesaurus_query.vim'
" Bundle 'ciaranm/securemodelines'

if ! has('nvim')
    packadd matchit
endif

" Enable filetype detection and load plugin files
if has('autocmd')
    filetype plugin indent on
endif
let $VIM='~/.vim'

" =============================================================================
" Appearance
" =============================================================================

syntax on

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif

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
