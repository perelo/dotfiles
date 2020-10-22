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
"   * support grep : switch '-Q' to '-F' ? 'grep -P'
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
  let l:files = map(a:000[1:-1], "expand(v:val)")
  return system(join([ &grepprg, a:000[0] ] + l:files, ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar -bang Grep  cgetexpr <SID>Grep(<f-args>) | CWindow<bang>
command! -nargs=+ -complete=file_in_path -bar -bang LGrep lgetexpr <SID>Grep(<f-args>) | LWindow<bang>

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" grep lines in files from different directories, see grep.vim
nnoremap <leader>ff :Grep!  %<S-Left><Left>
nnoremap <leader>fh :Grep!  %:p:h<S-Left><Left>
nnoremap <leader>fp :Grep!  .<S-Left><Left>
nnoremap <leader>fd :Grep!  $HOME/dotfiles/<S-Left><Left>
nnoremap <leader>fr :Grep!  $VIMRUNTIME<S-Left><Left>


function! s:GrepOperatorCmdline(type)
  call setreg('"', GetSelection(a:type))
  call feedkeys(":Grep! " . shellescape(getreg('"')) . " -Q ")
endfunction

function! s:GrepOperatorExec(dir, type)
  call setreg('"', GetSelection(a:type))
  let l:cmd = "Grep! " . shellescape(getreg('"')) . " -Q " . a:dir
  call histadd(':', l:cmd)
  execute l:cmd
  echo l:cmd
endfunction

" directories for which I want a mapping
let s:dirs = {
      \ 'buffer' : "%",
      \ 'here' : "%:p:h",
      \ "path" : ".",
      \ "dotfiles" : "$HOME/dotfiles/",
      \ "vimruntime" : "$VIMRUNTIME",
      \ }

" create the partials functions to use as 'operatorfunc'
for [s:key, s:val] in items(s:dirs)
  exe ":func! s:GrepOperator_" . s:key . "(type)"
    exe "call <SID>GrepOperatorExec('" . s:val . "', a:type)"
  endfun
endfor

nnoremap <leader>fF :set operatorfunc=<SID>GrepOperator_buffer<cr>g@
nnoremap <leader>fH :set operatorfunc=<SID>GrepOperator_here<cr>g@
nnoremap <leader>fP :set operatorfunc=<SID>GrepOperator_path<cr>g@
nnoremap <leader>fD :set operatorfunc=<SID>GrepOperator_dotfiles<cr>g@
nnoremap <leader>fR :set operatorfunc=<SID>GrepOperator_vimruntime<cr>g@
nnoremap <leader>f: :set operatorfunc=<SID>GrepOperatorCmdline<cr>g@

xnoremap <leader>ff :<c-u>call <SID>GrepOperatorExec('%', visualmode())<CR>
xnoremap <leader>fh :<c-u>call <SID>GrepOperatorExec('%:p:h', visualmode())<CR>
xnoremap <leader>fp :<c-u>call <SID>GrepOperatorExec('', visualmode())<CR>
xnoremap <leader>fd :<c-u>call <SID>GrepOperatorExec('$HOME/dotfiles/', visualmode())<CR>
xnoremap <leader>fr :<c-u>call <SID>GrepOperatorExec('$VIMRUNTIME', visualmode())<CR>
xnoremap <leader>f: :<c-u>Grep! <C-R>=shellescape(GetVisualSelection())<CR> -Q<Space>

nnoremap <leader>R :<c-u>cdo s/\<<C-R>"\>
