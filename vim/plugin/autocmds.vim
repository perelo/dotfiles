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

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    cwindow
    autocmd VimEnter        *     cwindow
augroup END

" Don't keep netrw buffers, wipe them off if they are hidden
augroup netrw
    autocmd!
    autocmd FileType netrw setlocal bufhidden=wipe
    autocmd BufEnter NetrwTreeListing* setlocal filetype=netrw
augroup END

" }}}
" {{{ filetype specific, new extensions must be in ftdetect/extension.vim

augroup ft
    autocmd!
    " Make sure all markdown files have the correct filetype
    autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set filetype=markdown

    " Tex files must be 'tex' filetype not 'plaintex'
    autocmd BufRead,BufNewFile *.{tex} set filetype=tex
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
