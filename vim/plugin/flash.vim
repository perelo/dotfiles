" From the discussion on reddit
" https://www.reddit.com/r/vim/comments/j62xmk/vim_and_ctags_make_ctrl_more_useful/

function! FlashOptionSet(option, how, what)
    let s:option = a:option
    exe 'let s:saved_option = &'.a:option
    let s:saved_updatetime = &updatetime
    if &updatetime > 200 | let &updatetime = 200 | endif
    augroup FlashOptionSetAug
        autocmd CursorHold,CursorHoldI <buffer> ++once
                    \ let &updatetime = s:saved_updatetime |
                    \ exe 'let &'.s:option.' = s:saved_option' |
    augroup END
    exe 'set '.a:option.a:how.a:what
endfunction
nnoremap <buffer> <silent> <C-]> :call FlashOptionSet('isk', '+=', ':,-')<CR><C-]>
nnoremap <buffer> <silent> (d     :call FlashOptionSet('isk', '-=', '_')<CR>[d


" From u/dddbbb

function! RunCommandWithOption(option, what, cmd)
    let bufname = bufname()
    let saved_option = getbufvar(bufname, a:option)
    call setbufvar(bufname, a:option, a:what)
    exe a:cmd
    call setbufvar(bufname, a:option, saved_option)
endf
" :call RunCommandWithOption('&iskeyword',  &iskeyword .. ',:,.', "normal! \<C-]>")
