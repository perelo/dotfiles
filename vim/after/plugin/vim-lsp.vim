
" LSP plugins combinations
"   * vim-lsp, vim-lsp-settings, asyncomplete.vim, asyncomplete-lsp.vim
"   * ALE for linting?
"
" TODO guards for vim9script
"

" https://github.com/prabirshrestha/vim-lsp
if !exists('g:lsp_loaded') || g:lsp_loaded == 0
    finish
endif
let g:lsp_loaded = 1

if has('nvim')
    setl omnifunc=v:lua.vim.lsp.omnifunc
endif

if executable('gopls')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
endif
if executable('cuepls')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cuepls',
        \ 'cmd': {server_info->['cuepls']},
        \ 'allowlist': ['cue'],
        \ })
endif


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> <leader>l* <plug>(lsp-document-symbol-search)
    nmap <buffer> <leader>ld <plug>(lsp-definition)
    " nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> <leader>lr <plug>(lsp-references)
    nmap <buffer> <leader>li <plug>(lsp-implementation)
    nmap <buffer> <leader>lt <plug>(lsp-type-definition)
    nmap <buffer> <leader>mv <plug>(lsp-rename)
    nmap <buffer> <leader>(q <plug>(lsp-previous-diagnostic)
    nmap <buffer> <leader>)q <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    nnoremap <buffer> <leader>ll :<c-u>LspDocumentDiagnostics<CR><C-W><C-P>
    nnoremap <buffer> <leader>lL :<c-u>lclose<CR>

    let g:lsp_diagnostics_enabled = 1
    " let g:lsp_diagnostics_echo_cursor = 1
    " let g:lsp_diagnostics_float_cursor = 1
    " let g:lsp_inlay_hints_enabled = 1

    let g:lsp_diagnostics_signs_enabled = 1
    let g:lsp_document_code_action_signs_enabled = 0
    setlocal signcolumn=number

    let g:lsp_diagnostics_virtual_text_align = "right"
    let g:lsp_diagnostics_virtual_text_prefix = " ‣ "
    hi! link LspErrorVirtualText Comment

    hi! link LspErrorHighlight Underlined

endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

