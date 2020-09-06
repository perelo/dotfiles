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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'chriskempson/base16-vim'
Plug 'matze/vim-tex-fold'
Plug 'gibiansky/vim-latex-objects' " TODO% fix 'dam' when cursor in on '$'
Plug 'file:///home/eloi/dotfiles/fzf/'
Plug 'junegunn/fzf.vim'
" Plug 'ciaranm/securemodelines'
Plug 'coderifous/textobj-word-column.vim'
Plug 'romainl/vim-qf'
Plug 'romainl/vim-tinyMRU'
Plug 'cespare/vim-toml'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-endwise'


Plug 'natebosch/vim-lsc'

Plug 'benmills/vimux'
Plug 'jpalardy/vim-slime'

Plug 'dpelle/vim-LanguageTool'

" Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Plug 'dense-analysis/ale'

" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

" Plug 'perelo/thesaurus_query.vim'
Plug 'file:///home/eloi/workspace/thesaurus_query.vim/'

call plug#end()

packadd! jumpy.vim
packadd! cfilter

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
