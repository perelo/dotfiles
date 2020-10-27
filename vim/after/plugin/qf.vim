if !exists("g:loaded_qf") || g:loaded_qf == 0
    finish
endif
let g:loaded_qf = 1

let g:qf_mapping_ack_style = 1

" unimpaired style, lose '&list' toogle
nmap yoq <Plug>(qf_qf_toggle_stay)
nmap yol <Plug>(qf_loc_toggle_stay)

