"
"   ltyc: a "compiler" for Vim,
"         invokes LanguageTool with YaLafi as LaTeX filter
"

if exists("current_compiler")
    finish
endif
let current_compiler = "ltyc"

" older Vim always used :setlocal
if exists(':CompilerSet') != 2
    command! -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

"   check installation components
"
let s:pref = 'In order to use the ltyc compiler, please '
if !executable('python')
    echoerr s:pref . 'install Python.'
    finish
endif
call system('python -c "import yalafi"')
if v:shell_error != 0
    echoerr s:pref . 'install the Python module YaLafi.'
    finish
endif
if g:ltyc_server != 'lt'
    if !executable('java')
        echoerr s:pref . 'install Java.'
        finish
    endif
    if !filereadable(fnamemodify(g:ltyc_ltdirectory
                            \ . '/languagetool-commandline.jar', ':p'))
        echoerr s:pref . 'set g:ltyc_ltdirectory to the'
                    \ . ' path of LanguageTool.'
        finish
    endif
endif

"   config variables
let g:ltyc_ltdirectory = '~/tools/LanguageTool-5.1/'    " home of LT software
let g:ltyc_server = 'my'                                " use an LT server?
let g:ltyc_language = 'fr'                              " language code for LT
let g:ltyc_disable = 'WHITESPACE_RULE,FR_SPELLING_RULE' " LT option --disable
let g:ltyc_enable = ''                                  " LT option --enable
let g:ltyc_disablecategories = ''                       " LT option --disablecategories
let g:ltyc_enablecategories = ''                        " LT option --enablecategories
let g:ltyc_showsuggestions = 0                          " if set to 1: show LT's replacement suggestions
let g:ltyc_shelloptions = '--define main/macros.sty' " further options passed to yalafi.shell


let &l:makeprg =
        \ 'python -m yalafi.shell'
        \ . ' --lt-directory ' . g:ltyc_ltdirectory
        \ . (g:ltyc_server == '' ? 
                    \ '' : ' --server ' . g:ltyc_server)
        \ . ' --language ' . g:ltyc_language
        \ . ' --disable "' . g:ltyc_disable . '"'
        \ . ' --enable "' . g:ltyc_enable . '"'
        \ . ' --disablecategories "' . g:ltyc_disablecategories . '"'
        \ . ' --enablecategories "' . g:ltyc_enablecategories . '"'
        \ . ' ' . g:ltyc_shelloptions
        \ . ' %:S'

let &l:errorformat = '%I=== %f ===,%C%*\d.) Line %l\, column %v\, Rule ID:%.%#,'
if g:ltyc_showsuggestions == 0
  let &l:errorformat .= '%ZMessage: %m,%-G%.%#'
else
  let &l:errorformat .= '%CMessage: %m,%Z%m,%-G%.%#'
endif

silent CompilerSet makeprg
silent CompilerSet errorformat

let &cpo = s:cpo_save
unlet s:cpo_save

