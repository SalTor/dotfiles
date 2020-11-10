let g:sneak#label=1
let g:sneak#s_next=0

nmap <expr> x sneak#is_sneaking() ? '<Plug>Sneak_;' : '<Plug>Sneak_s'
nmap <expr> X sneak#is_sneaking() ? '<Plug>Sneak_,' : '<Plug>Sneak_S'

xmap <expr> x sneak#is_sneaking() ? '<Plug>Sneak_;' : '<Plug>Sneak_s'
xmap <expr> X sneak#is_sneaking() ? '<Plug>Sneak_,' : '<Plug>Sneak_S'

xmap s s
