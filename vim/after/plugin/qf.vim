if !exists("g:loaded_qf") || g:loaded_qf == 0
    finish
endif

let g:qf_mapping_ack_style = 1
let g:qf_loclist_window_bottom = 0
let g:qf_bufname_or_text = 0        " 0:buffer&text, 1:buffer, 2:text

let g:qf_statusline = {}
let g:qf_statusline.before = '%q%<\ '
let g:qf_statusline.after = '\ %=%l\/%-6L\ \ \ \ \ '

" unimpaired style, lose '&list' toogle
nmap yoq <Plug>(qf_qf_toggle_stay)
nmap yol <Plug>(qf_loc_toggle_stay)

