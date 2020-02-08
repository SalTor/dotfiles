let g:fzf_colors = {
    \ 'fg+':    ['fg', 'Label'],
    \ 'bg+':    ['bg', 'Normal'],
    \ 'border': ['fg', 'Label'],
    \ 'hl':     ['fg', 'Statement'],
    \ 'hl+':    ['fg', 'Statement'],
    \ }

let g:fzf_action = {
    \ 'ctrl-q': function('saltor#functions#build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
