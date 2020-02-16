let g:fzf_layout = {'window': { 'width': 0.6, 'height': 0.75, 'highlight': 'Label' }}

let g:fzf_colors = {
    \ 'fg+':    ['fg', 'Label'],
    \ 'bg+':    ['bg', 'Normal'],
    \ 'border': ['fg', 'Comment'],
    \ 'hl':     ['fg', 'Statement'],
    \ 'hl+':    ['fg', 'Statement'],
    \ }

let g:fzf_action = {
    \ 'ctrl-q': function('saltor#functions#build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
