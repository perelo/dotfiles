" buffers from firenvim's firefox plugin config

if has('nvim') && get(g:, 'started_by_firenvim', 0)
  set showtabline=0   " deactivate buftabline
  set laststatus=1    " only if there are at least two windows
  if exists('g:buftabline_show')
    let g:buftabline_show=1
  endif

  let g:firenvim_config = {
      \ 'globalSettings': {
          \ '<C-w>': 'noop',
      \ }
      \ }
endif
