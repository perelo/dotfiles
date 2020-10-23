"
" Modified and upgraded versions of
"   * 'Instant grep + quickfix' from romainl
"     https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
"       - Add '!' to :Grep to keep the cursor in the current buffer
"       - Modify :Grep to not use 'expandcmd()' for neovim compatibility
"   * Case Study: Grep Operator Part Three
"     https://learnvimscriptthehardway.stevelosh.com/chapters/34.html
" and convenient <leader>f{x} mappings to list results of searches.
" The unnamed register is set to the searched text after an operator-pending
" or visual mapping.
" 'nnoremap <leader>R' enters a pre-filled command-line to replace @"
"
" Dependencies :
"   * CWindow and LWindow in commands.vim
"   * GetVisualSelection() and GetSelection() in functions.vim
"
" TODO :
"   * support vim-qf's 'Doline' insead of 'cdo'
"   * add git-grep, rg support ?
"   * add guards to check version. It should be at most 8.0, maybe 7.4
"   * maybe inject `setreg('"', ...)` into Grep directly. It would be more
"     consistent with the moments where ':Grep ...' is not pre-filled with an
"     operator-pending or visual mapping.
"   * choose or make another set of mappings to choose between LGrep and Grep
"

if executable('ag')
    set grepprg=ag\ --vimgrep
endif

function! s:Grep(...)
  " construct the parameters to pass to &grepprg and
  " insert them in the &grepprg : either in the placeholder $* or at the end
  let l:params = join([ a:000[0] ] + map(a:000[1:-1], "expand(v:val)"), " ")
  return system(substitute(&grepprg, '\(\$\*\|$\)', " " . l:params, ""))
endfunction

command! -nargs=+ -complete=file_in_path -bar -bang Grep  cgetexpr <SID>Grep(<f-args>) | CWindow<bang>
command! -nargs=+ -complete=file_in_path -bar -bang LGrep lgetexpr <SID>Grep(<f-args>) | LWindow<bang>

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" grep lines in files from different directories
nnoremap <leader>ff :Grep!  %<S-Left><Left>
nnoremap <leader>fh :Grep!  %:p:h<S-Left><Left>
nnoremap <leader>fp :Grep!  .<S-Left><Left>
nnoremap <leader>fd :Grep!  $HOME/dotfiles/<S-Left><Left>
nnoremap <leader>fr :Grep!  $VIMRUNTIME<S-Left><Left>


"
" Below, the searched text is extracted from the current buffer,
" so we want to search for litteral (fixed) strings.
"

function! s:GetLitteralFlag()
  if &grepprg =~ "^grep"
    let s:litteral_flag = "-F"
  elseif &grepprg =~ "^ag"
    let s:litteral_flag = "-Q"
  endif
endfunction
call <SID>GetLitteralFlag()

augroup GrepLitteralFlag
  au!
  autocmd OptionSet grepprg call <SID>GetLitteralFlag()
augroup END

function! s:GetGrepCmdLitteral(type)
  call setreg('"', GetSelection(a:type))
  return 'Grep! ' . shellescape(getreg('"')) . ' ' . s:litteral_flag
endfunction

function! s:GrepCmdline(type)
  call feedkeys(':' . <SID>GetGrepCmdLitteral(a:type) . ' ')
endfunction

function! s:GrepExec(dir, type)
  let l:cmd = <SID>GetGrepCmdLitteral(a:type) . ' ' . a:dir
  call histadd(':', l:cmd)
  execute l:cmd
  echo l:cmd
endfunction

xnoremap <leader>ff :<c-u>call <SID>GrepExec('%', visualmode())<CR>
xnoremap <leader>fh :<c-u>call <SID>GrepExec('%:p:h', visualmode())<CR>
xnoremap <leader>fp :<c-u>call <SID>GrepExec('', visualmode())<CR>
xnoremap <leader>fd :<c-u>call <SID>GrepExec('$HOME/dotfiles/', visualmode())<CR>
xnoremap <leader>fr :<c-u>call <SID>GrepExec('$VIMRUNTIME', visualmode())<CR>

nnoremap <leader>f: :set operatorfunc=<SID>GrepCmdline<cr>g@
xnoremap <leader>f: :<c-u><C-R>=<SID>GetGrepCmdLitteral(visualmode())<CR><Space>


"
" Now, create the operator-pending mappings.
"

" directories for which there is a mapping
let s:dirs = {
      \ 'buffer' : "%",
      \ 'here' : "%:p:h",
      \ "path" : ".",
      \ "dotfiles" : "$HOME/dotfiles/",
      \ "vimruntime" : "$VIMRUNTIME",
      \ }

" create the partials functions to use as 'operatorfunc'
for [s:key, s:val] in items(s:dirs)
  exe ":function! s:Grep_" . s:key . "(type) \n" .
    \   "call <SID>GrepExec('" . s:val . "', a:type) \n" .
    \ "endfunction"
endfor

nnoremap <leader>fF :set operatorfunc=<SID>Grep_buffer<cr>g@
nnoremap <leader>fH :set operatorfunc=<SID>Grep_here<cr>g@
nnoremap <leader>fP :set operatorfunc=<SID>Grep_path<cr>g@
nnoremap <leader>fD :set operatorfunc=<SID>Grep_dotfiles<cr>g@
nnoremap <leader>fR :set operatorfunc=<SID>Grep_vimruntime<cr>g@

nnoremap <leader>R :<c-u>cdo s/\<<C-R>"\>
