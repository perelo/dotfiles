if !has('autocmd')
    echom 'Vim doesn''t have +autocmd, don''t source autocmds.vim'
    finish
endif

" Copied from defaults.vim
" Put these in an autocmd group, so that you can revert them with:
" :augroup vimStartup | au! | augroup END
augroup vimStartup
  au!
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

" don't map <CR> and <BS> in quickfix and commandline-mode
augroup cr_bs
    au!
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
    autocmd BufReadPost quickfix nnoremap <buffer> <BS> <BS>
    autocmd CmdwinEnter * nnoremap <buffer> <BS> <BS>
augroup END

augroup LargeFile
    let g:large_file = 10485760 " 10MB
    " Set options:
    "   eventignore+=FileType (no syntax highlighting etc
    "   assumes FileType always on)
    "   noswapfile (save copy of file)
    "   bufhidden=unload (save memory when other file is viewed)
    "   buftype=nowritefile (is read-only)
    "   undolevels=-1 (no undo possible)
    au BufReadPre *
        \ let f=expand("<afile>") |
        \ if getfsize(f) > g:large_file |
        \ set eventignore+=FileType |
        \ setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 |
        \ else |
        \ set eventignore-=FileType |
        \ endif
augroup END

augroup NewSplit
  autocmd!
  " autocmd WinNew * au BufEnter * ++once call <SID>NewSplit()
aug end
function! <SID>NewSplit()
  " move help, man and fugitive windows at the far right/left if enough space
  if (&bt ==? 'help' || &ft ==? 'man' || &ft ==? 'fugitive')
    let p = winnr('#')
    if winwidth(p) >= getwinvar(p, '&tw', 80) + getwinvar(winnr(), '&tw', 80)
      execute 'wincmd ' . (&splitright ? 'L' : 'H')
    endif
  endif
endfunction

" Don't keep netrw buffers, wipe them off if they are hidden
augroup netrw
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufEnter NetrwTreeListing* setlocal filetype=netrw
augroup END

" if exists('+colorcolumn')
"     " unfocused windows are getting colorcolumn'd
"     augroup ColorColumnFocus
"         au!
"         autocmd BufEnter,FocusGained,VimEnter,WinEnter * setl colorcolumn=+2
"         autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1,255),',')
"     augroup END
" endif

" }}}
" {{{ filetype specific, new extensions should be in ../ftdetect/extension.vim

augroup ft
    autocmd!
    " Make sure all markdown files have the correct filetype
    autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setlocal filetype=markdown

    " Tex files must be 'tex' filetype not 'plaintex'
    autocmd BufRead,BufNewFile *.{tex} setlocal filetype=tex

    " Life filetype for *.lf files
    au BufNewFile,BufRead *.lf setlocal filetype=life

    " Life filetype for *.lf files
    au BufNewFile,BufRead *.txtar setlocal filetype=txt

    " K-Framework filetype for *.k files
    au BufNewFile,BufRead *.k setlocal filetype=kframework
augroup END

" }}}
" {{{ skeletons - tidy and do something with ultisnips

augroup skeleton
    autocmd!
    autocmd BufNewFile *.tex 0r $VIM/skeletons/tex_header.txt
    autocmd BufNewFile *.tex exe "/title"

    autocmd BufNewFile *.py so $VIM/skeletons/py_header.txt
    autocmd BufNewFile *.py exe "% s/\\(.*author.*\\)/\\1 '" .$USER ."'"
    autocmd BufNewFile *.py exe "% s/\\(.*date.*\\)/\\1 '" .strftime("%d-%m-%Y") ."'"
    autocmd BufNewFile *.py exe "normal! G"

    autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} so $VIM/skeletons/c_header.txt
    autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([fF]ile\\)/\\1 " .expand("%")
    autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([aA]uthor\\)/\\1 " .$USER
    autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "% s/\\([dD]ate\\)/\\1 " .strftime("%d-%m-%Y")
    autocmd BufNewFile *.{c,cpp,cxx,h,hpp,hxx} exe "normal! G"

    autocmd BufNewFile *.hs so $VIM/skeletons/hs_header.txt
    autocmd BufNewFile *.hs exe "% s/\\([fF]ile\\)/\\1 " .expand("%")
    autocmd BufNewFile *.hs exe "% s/\\([aA]uthor\\)/\\1 " .$USER
    autocmd BufNewFile *.hs exe "% s/\\([dD]ate\\)/\\1 " .strftime("%d-%m-%Y")
    autocmd BufNewFile *.hs exe "normal! G"

    " Insert macro gate
    autocmd BufNewFile *.{h,hpp,hxx} call InsertMacroGate()
    autocmd BufNewFile *.{c,cpp,cxx} exe "normal! o"
augroup END

" }}}
" vim: fdm=marker
