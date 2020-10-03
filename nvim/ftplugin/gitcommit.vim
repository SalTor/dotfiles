setlocal spell spelllang=en_us
setlocal dictionary+=/usr/share/dict/words
setlocal complete+=kspell
setlocal colorcolumn=72
let g:coc_source_disable_map = {
    \ 'gitcommit': ['buffer', 'around', 'word', 'file'],
    \ }
