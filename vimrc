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

" Extend insert-completion, see plugin/ctrlx.vim
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-CompleteHelper'
Plug 'inkarkat/vim-WORDComplete'
Plug '~/.vim/plugin/vim-LineComplete'   " script_id=4911
Plug '~/.vim/plugin/vim-AlphaComplete'  " script_id=4912

" Plug 'gibiansky/vim-latex-objects' " TODO% fix 'dam' when cursor in on '$'
Plug 'file:///home/eloi/workspace/vim-latex-objects/'
Plug 'coderifous/textobj-word-column.vim'
" Plug 'Konfekt/vim-sentence-chopper'
Plug 'perelo/vim-sentence-chopper'

Plug 'natebosch/vim-lsc'

Plug 'benmills/vimux'
Plug 'jpalardy/vim-slime'

if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

" Plug 'perelo/thesaurus_query.vim'
Plug 'file:///home/eloi/workspace/thesaurus_query.vim/'

Plug 'Yggdroot/indentLine'
call plug#end()

" Set comma as <leader> instead of default backslash
let mapleader = ","
noremap ,, ,

packadd! jumpy.vim
if has('patch-8.1.0311')
  packadd! cfilter
endif

if !has('nvim')
    packadd matchit
endif

packadd! azerty

" disable default Vimball plugin
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

let g:indentLine_char = '┆'
let g:indentLine_bufTypeExclude = ['help', 'quickfix', 'nofile']
let g:indentLine_fileTypeExclude = [ 'help', 'text', 'gitcommit', 'tex', 'vim']


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

" static directories which are interesting to me.
" see plugin/mappings.vim, plugin/grep.vim, after/plugin/fzf.vim
let g:my_dirs = {
      \ 'buffer' : "'%'",
      \ 'here' : "'%:p:h'",
      \ 'path' : "'.'",
      \ 'gitdir' : "GitRootDir('%')",
      \ 'dotfiles' : "'$HOME/dotfiles'",
      \ 'workspace' : "'$HOME/workspace'",
      \ 'vimfiles' : "'$VIM'",
      \ 'runtime' : "'$VIMRUNTIME'",
      \ }


" =============================================================================
" Appearance
" =============================================================================

if has('syntax')
  syntax on
endif
so $VIM/plugin/statusline.vim

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif
