" =============================================================================
" Initialization
" =============================================================================

" Clear autocmds
autocmd!

""
"" vim-plug
""

call plug#begin("~/.vim/bundle")

""
"" My bundles here
""

" original repos on GitHub
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'michaeljsmith/vim-indent-object'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-buftabline'
Plug 'wellle/targets.vim'
Plug 'itchyny/lightline.vim'
Plug 'kien/ctrlp.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'chriskempson/base16-vim'
Plug 'wincent/ferret'
Plug 'matze/vim-tex-fold'
Plug 'gibiansky/vim-latex-objects'
Plug 'perelo/thesaurus_query.vim'
Plug 'arp242/jumpy.vim'
" Plug 'ciaranm/securemodelines'

call plug#end()

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
