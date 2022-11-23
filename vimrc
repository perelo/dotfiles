" =============================================================================
" Initialization
" =============================================================================

" Clear autocmds
autocmd!

""
"" vim-plug, see $HOME/.vim/autoload/plug.vim
""

call plug#begin(has('nvim') ? stdpath('config') . "/plugged" : "~/.vim/bundle")

" 
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-easy-align'
Plug 'wellle/targets.vim'
Plug 'arp242/jumpy.vim'
Plug 'mbbill/undotree'
Plug 'chriskempson/base16-vim'
" Plug 'ciaranm/securemodelines'
Plug 'romainl/vim-qf'
Plug 'romainl/vim-qlist'
Plug 'coderifous/textobj-word-column.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/vim-gitbranch'

" insert-completion, also AlphaCompelte and LineComplete below
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-CompleteHelper'
Plug 'inkarkat/vim-WORDComplete'

" syntax files
Plug 'cespare/vim-toml'
Plug 'tpope/vim-liquid'
Plug 'vmchale/dhall-vim'
Plug 'jvirtanen/vim-hcl'

" ftplugins
if has('python3') && executable('pandoc')
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
endif

Plug 'preservim/vim-markdown'
Plug 'jjo/vim-cue'

" snippets
if has('python3')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif

" fuzzy
Plug 'file://'.$HOME.'/dotfiles/fzf/'
Plug 'junegunn/fzf.vim'

" file-related
Plug 'tpope/vim-vinegar'
" Plug 'moll/vim-bbye'
Plug 'ap/vim-buftabline'

" lsp-related
Plug 'natebosch/vim-lsc'

" out-of-vim related
Plug 'tpope/vim-eunuch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'jpalardy/vim-slime'
if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

call plug#end()

" vimball plugins
packadd! AlphaComplete    " https://www.vim.org/scripts/script.php?script_id=4912
packadd! LineComplete     " https://www.vim.org/scripts/script.php?script_id=4911
packadd! SwapText         " https://www.vim.org/scripts/script.php?script_id=4971

" my plugin
packadd! azerty

" contributing
packadd! thesaurus_query.vim
packadd! vim-latex-objects
packadd! vim-sentence-chopper



" default plugins
if has('patch-8.1.0311')
  packadd! cfilter
endif
if !has('nvim')
    packadd! matchit
endif

" disable default Vimball plugin
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1



let $VIM='~/.vim'
let mapleader = ","
noremap ,, ,

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

" netrw config
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 1     " like ls
let g:netrw_hide = 1
let g:netrw_altfile = 1       " keep the alternate buffer !

" indentLine config
" let g:indentLine_enabled = 0
let g:indentLine_char = '|'
let g:indentLine_color_term = 202
let g:indentLine_fileType = ['yaml']
let g:indentLine_bufTypeExclude = ['help', 'quickfix', 'nofile']
let g:indentLine_fileTypeExclude = [ 'help', 'text', 'gitcommit', 'tex', 'vim']


" Enable filetype detection and load plugin files
if has('autocmd')
    filetype plugin indent on
endif

" =============================================================================
" Appearance
" =============================================================================

if has('syntax')
  syntax on
endif
so $VIM/plugin/statusline.vim

if has('nvim')
  Plug 'RRethy/nvim-base16'
endif
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif
