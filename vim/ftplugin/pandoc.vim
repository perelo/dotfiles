setl ts=4 sts=4 sw=4
setl expandtab

" <!> may conflict with other plugins
let g:pandoc#filetypes#pandoc_markdown = 1

source $VIM/after/ftplugin/markdown.vim

if filereadable(expand('$VIM/bundle/jumpy.vim/after/ftplugin/markdown.vim'))
    source $VIM/bundle/jumpy.vim/after/ftplugin/markdown.vim
endif

 " remove 'gf', 'gx', ',xi' mappings
let g:pandoc#hypertext#use_default_mappings = 0



