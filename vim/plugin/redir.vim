function! Redir(mods, ...)
    let l:cmd = a:000[0] == '' ? histget(':', -2) : a:000[0]
    if l:cmd =~# 'Redir'
        echoerr 'Trying to redirect recursively with command "'.l:cmd.'"'
        return
    endif
    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win . 'windo close'
        endif
    endfor
    if l:cmd =~ '^!'
        let output = system(matchstr(l:cmd, '^!\zs.*'))
    else
        redir => output
        execute l:cmd
        redir END
    endif
    execute a:mods 'new'
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    call setline(1, split(output, "\n"))
endfunction

command! -nargs=? -complete=command Redir silent call Redir('<mods>', <q-args>)

" Usage:
"   :Redir hi ...... show the full output of command ':hi' in a scratch window
"   :Redir !ls -al . show the full output of command ':!ls -al' in a scratch window
