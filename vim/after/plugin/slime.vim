if !exists('g:loaded_slime') || g:loaded_slime == 0
    finish
endif

let g:slime_target = "tmux"
let g:slime_paste_file = expand('$VIM/tmp/.slime_paste')
let g:slime_default_config = {
    \ "socket_name": get(split($TMUX, ","), 0),
    \ "target_pane": ":.2"}

let g:slime_no_mappings = 1
xmap <leader>r <Plug>SlimeRegionSend
nmap <leader>r <Plug>SlimeMotionSend
nmap <leader>rr <Plug>SlimeLineSend
