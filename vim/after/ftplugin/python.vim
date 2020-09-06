setlocal foldmethod=indent

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'python3 '.expand('%')<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'python3 '.expand('%')<CR>
endif
" inoremap <buffer> <F1> <esc>:silent w <bar> :SlimeSend<CR>
" nnoremap <buffer> <F1> :silent w <bar> :SlimeSend<CR>
" nnoremap <buffer> <F2> :silent w <bar> :?\(from\\|import\)?-1,.SlimeSend<CR>

if executable('autoflake')
    nnoremap <buffer> <silent> <F5> 
                \ :w<CR>
                \ :!autoflake -i --remove-all-unused-imports %<CR>
                \ :e!<CR>
endif

if exists('g:loaded_ale') && g:loaded_ale == 1
    let b:ale_linters = { 'python' : ['pyflakes'] }
    let b:ale_python_pylint_auto_pipenv = 1
    let b:ale_python_pylint_options = '--jobs=0 --errors-only'
endif
