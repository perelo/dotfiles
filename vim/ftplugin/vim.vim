augroup SourceOnWrite
    au!
    if &filetype == 'vim'
        autocmd BufWritePost <buffer> source %
    endif
augroup END
set iskeyword-=#
