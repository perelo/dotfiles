if !exists('g:loaded_lsc') || g:loaded_lsc == 0
    finish
endif

let g:lsc_server_commands = {
  \ 'python': {
  \   'command': 'pyls',
  \   'log_level': -1,
  \   'suppress_stderr': v:true
  \ },
  \}

let g:lsc_enable_autocomplete  = v:true
let g:lsc_enable_diagnostics   = v:false
let g:lsc_reference_highlights = v:true

let g:lsc_auto_map = {
  \ 'GoToDefinition'      : '<C-]>',
  \ 'GoToDefinitionSplit' : '<C-W><C-]>',
  \ 'FindReferences'      : 'gr',
  \ 'NextReference'       : '<C-n>',
  \ 'PreviousReference'   : '<C-p>',
  \ 'FindImplementations' : 'gI',
  \ 'DocumentSymbol'      : 'go',
  \ 'WorkspaceSymbol'     : 'gS',
  \ 'FindCodeActions'     : 'ga',
  \ 'Rename'              : 'gR',
  \ 'SignatureHelp'       : 'gm',
  \ 'ShowHover'           : 'K',
  \ 'Completion'          : 'completefunc'
\}
