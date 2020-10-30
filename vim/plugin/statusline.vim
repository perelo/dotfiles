set laststatus=2         " Always display statusline

let mode_map = {
\     'n':'NORMAL', 'i':'INSERT', 'R':'REPLACE', 'c':'COMMAND',
\     'v':'VISUAL', 'V': 'V-LINE', "\<C-v>": 'V-BLOCK',
\     's': 'SELECT', 'S': 'S-LINE', "\<C-s>": 'S-BLOCK',
\     't': 'TERMINAL'
\     }

hi StatusLineLeft ctermfg=148 ctermbg=240 guifg=#afdf00 guibg=#585858
hi StatusLineYellow term=bold cterm=bold ctermfg=22 ctermbg=148 gui=bold guifg=#005f00 guibg=#afdf00
hi StatusLineLeft ctermfg=231 ctermbg=240 guifg=#ffffff guibg=#585858
hi StatusLineWhite ctermfg=241 ctermbg=252 guifg=#606060 guibg=#d0d0d0
hi StatusLineGray ctermfg=250 ctermbg=240 guifg=#bcbcbc guibg=#585858
hi StatusLineNormalRight ctermfg=247 ctermbg=236 guifg=#9e9e9e guibg=#303030
hi StatusLineMiddle ctermfg=245 ctermbg=236 guifg=#8a8a8a guibg=#303030

function! StatusLine(winnum)
  if a:winnum != winnr()
    " unfocused statusline
    return '%#StatusLineNC# %f %(| %M%)'
  else
    " focused statusline
    let l:stl = ''
    let l:stl .= '%#StatusLineYellow#'
    let l:stl .= ' '
    let l:stl .= '%{get(mode_map,mode(),"")} '     " mode
    let l:stl .= '%( %{&paste?"PASTE":""} %)'     " PASTE
    let l:stl .= '%#StatusLineLeft#'
    let l:stl .= '%( %R |%)'                       " RO
    let l:stl .= '%( (%{gitbranch#name()})%)'      " git branch
    let l:stl .= '%( %t %)'                        " filename
    let l:stl .= '%(| %M %)'                       " modified
    let l:stl .= '%#StatusLineMiddle#'
    let l:stl .= '%='                              " >>>>>>>>>>>>>
    let l:stl .= '%#StatusLineNormalRight#'
    let l:stl .= '%( %{&ff} |%)'                   " fileformat
    let l:stl .= '%( %{&fenc!=#""?&fenc:&enc} |%)' " fileencoding
    let l:stl .= '%( %{&ft!=#""?&ft:"no ft"} %)'   " filetype
    let l:stl .= '%#StatusLineGray#'
    let l:stl .= ' %3p%% '                         " buffer's percent
    let l:stl .= '%#StatusLineWhite#'
    let l:stl .= ' %3l:%-2c  '                     " line and column
    return l:stl
  endif
endfunction

function! s:RefreshStatusLine()
  for n in range(1, winnr('$'))
    " let vim-qf do its job on quickfix windows.
    " see ../after/plugin/qf.vim for config
    if ! exists('g:loaded_qf') || getwinvar(n, '&filetype') != 'qf'
      call setwinvar(n, '&statusline', '%!StatusLine(' . n . ')')
    endif
  endfor
endfunction

" set w:curr to 1 on enter, 0 on leave
augroup statusline
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * call <SID>RefreshStatusLine()
augroup END

