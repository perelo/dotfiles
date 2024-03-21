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
Plug 'AndrewRadev/splitjoin.vim'

" yank form everywhere using OSC52
Plug 'greymd/oscyank.vim'

" insert-completion, also AlphaCompelte and LineComplete below
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-CompleteHelper'
Plug 'inkarkat/vim-WORDComplete'

" syntax files, apriori don't contain ftplugin/
Plug 'cespare/vim-toml'
Plug 'tpope/vim-liquid'
Plug 'vmchale/dhall-vim'
Plug 'Procrat/oz.vim'
Plug 'adimit/prolog.vim'
Plug 'kframework/k-editor-support', { 'rtp': 'vim' }
Plug 'preservim/vim-markdown'
Plug 'jjo/vim-cue'
Plug 'google/vim-jsonnet'
Plug 'nickel-lang/vim-nickel'

" language ftplugins
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['tex', 'cue', 'python']
if has('python3') && executable('pandoc')
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
endif

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

" lsp-related, vim
if ! has("nvim")
  Plug 'prabirshrestha/vim-lsp'
  let g:lsp_loaded = 1  " deactivate vim-lsp
  " Plug 'mattn/vim-lsp-settings'

  " Plug 'govim/govim'  " gopls
endif
if has('nvim')
  Plug 'neovim/nvim-lspconfig'
  Plug 'folke/lsp-colors.nvim'
endif

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
if ! has('nvim')
    packadd! matchit
endif

" disable default Vimball plugin
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1



let $VIM='~/.vim'
let mapleader = ","
noremap ,, ,

" " static directories which are interesting to me.
" " see $HOME/.vim/plugin/abbrev.vim, 
" " see $HOME/.vim/plugin/grep.vim
" " see $HOME/.vim/after/plugin/fzf.vim
" " \ 'b - buffer'     : "'%'",
" let g:my_dirs = {
"       \ 'h - here'       : "'%:p:h'",
"       \ 'p - path (pwd)' : "'.'",
"       \ 'g - gitdir'     : "GitRootDir('%')",
"       \ 'd - dotfiles'   : "'$HOME/dotfiles'",
"       \ 'w - workspace'  : "'$HOME/workspace'",
"       \ 'v - vimfiles'   : "'$VIM'",
"       \ 'r - runtime'    : "'$VIMRUNTIME'",
"       \ }

" netrw config
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 1     " like ls
let g:netrw_hide = 1
let g:netrw_altfile = 1       " keep the alternate buffer !

" indentLine config
" let g:indentLine_enabled = 0
let g:indentLine_char = "\u2502"
let g:indentLine_color_term = 202
let g:indentLine_fileType = ['yaml']
let g:indentLine_bufTypeExclude = ['help', 'quickfix', 'nofile']
let g:indentLine_fileTypeExclude = [ 'help', 'text', 'gitcommit', 'tex', 'vim']
" unimpaired style
nnoremap yod :<c-u>IndentLinesToggle<CR>


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
  Plug 'folke/lsp-colors.nvim'
endif
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  "prefered themes : unikitty-dark, atelier-dune, ocean
endif
