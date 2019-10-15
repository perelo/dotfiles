" Define a command to show specific marks that are currently set.
" mostly for debugging purposes

command! -range ShowMarks <line1>,<line2>call ShowMarks(visualmode())
" nnoremap <leader>m :set operatorfunc=ShowMarks<cr>g@

function! ShowMarks(vis) range abort
    echo "'< : " . line("'<") . ":" . col("'<")
    echo "'> : " . line("'>") . ":" . col("'>")
    echo "'[ : " . line("'[") . ":" . col("'[")
    echo "'] : " . line("']") . ":" . col("']")
    echo "range : " . a:firstline . "," . a:lastline
    echo mode() . ' ' . a:vis
endfunction
