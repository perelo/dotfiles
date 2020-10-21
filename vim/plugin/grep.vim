"
" Modified vertion of 'Instant grep + quickfix' from romainl
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
"
" TODO : grep operator
"
if executable('ag')
    set grepprg=ag\ --vimgrep
endif

function! s:Grep(...)
  let l:files = map(a:000[1:-1], "expand(v:val)")
  return system(join([ &grepprg, a:000[0] ] + l:files, ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar -bang Grep  cgetexpr <SID>Grep(<f-args>) | CWindow<bang>
command! -nargs=+ -complete=file_in_path -bar -bang LGrep lgetexpr <SID>Grep(<f-args>) | CWindow<bang>

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

" TODO
" nnoremap <leader>gh :execute "Grep " . shellescape(expand("<cword>")) . " ."<CR>
