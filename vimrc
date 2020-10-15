" TODO <C-X><C-W> to complete WORDS
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
" Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mbbill/undotree'
Plug 'chriskempson/base16-vim'
Plug 'file:///home/eloi/dotfiles/fzf/'
Plug 'junegunn/fzf.vim'
" Plug 'ciaranm/securemodelines'
Plug 'romainl/vim-qf'
Plug 'romainl/vim-tinyMRU'
Plug 'romainl/vim-qlist'
Plug 'cespare/vim-toml'
Plug 'AndrewRadev/splitjoin.vim'

" Plug 'gibiansky/vim-latex-objects' " TODO% fix 'dam' when cursor in on '$'
Plug 'file:///home/eloi/workspace/vim-latex-objects/'
Plug 'coderifous/textobj-word-column.vim'
" Plug 'Konfekt/vim-sentence-chopper'
Plug 'perelo/vim-sentence-chopper'

Plug 'natebosch/vim-lsc'

Plug 'benmills/vimux'
Plug 'jpalardy/vim-slime'

" Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Plug 'dense-analysis/ale'

" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

" Plug 'perelo/thesaurus_query.vim'
Plug 'file:///home/eloi/workspace/thesaurus_query.vim/'

Plug 'Yggdroot/indentLine'
call plug#end()

packadd! jumpy.vim
packadd! cfilter

if ! has('nvim')
    packadd matchit
endif


let g:indentLine_char = '┆'
let g:indentLine_bufTypeExclude = ['help', 'quickfix', 'nofile']
let g:indentLine_fileTypeExclude = [ 'help', 'text', 'tex', 'vim' ]


" Enable filetype detection and load plugin files
if has('autocmd')
    filetype plugin indent on
endif
let $VIM='~/.vim'

augroup TargetDollar
  au!
  autocmd User targets#mappings#user call targets#mappings#extend({
      \ '$': {'quote': [{'d': '\$'}]},
      \ 'r': {'pair': [{'o': 'cc', 'c': 'cc'}]},
      \ })
augroup END

" =============================================================================
" Appearance
" =============================================================================

syntax on

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif
