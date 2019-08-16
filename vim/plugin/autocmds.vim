
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
