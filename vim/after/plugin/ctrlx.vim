"
" Mimic ins-completion `<C-X>` behaviour and extend it
"

function! CtrlX()
  echohl ModeMsg
  echo '-- ^X mode (^]a^D^E^Ff^I^K^Ll^N^O^Ps^T^U^V^W^Y)'
  echohl None
  let l:c = nr2char(getchar())

  if get(g:, "loaded_AlphaComplete") && (l:c == "a" || l:c == "\<C-A>")
    return "\<Plug>(AlphaComplete)"
  elseif get(g:, "loaded_LineComplete") && (l:c == "l" || l:c == "\<C-L>")
    return "\<Plug>(LineComplete)"
  elseif get(g:, "loaded_WORDComplete") && l:c == "\<C-W>"
    return "\<Plug>(WORDComplete)"
  " elseif get(g:, "loaded_fzf") && (l:c == "f" || l:c == "\<C-F>")
  "   return "\<Plug>(fzf-complete-file-ag)"
  else
    return "\<C-X>" . l:c
  endif

endfunction
imap <nowait> <expr> <C-X> CtrlX()
