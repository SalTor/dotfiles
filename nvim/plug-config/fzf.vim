let g:fzf_buffers_jump = 1

let g:fzf_layout = {
    \ 'window': {
    \     'height': 0.5,
    \     'width': 1,
    \     'yoffset': 0,
    \     'highlight': 'PreProc',
    \ }}

let g:fzf_colors =
    \ {
    \ 'fg':      ['fg', 'Normal'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'bg+':     ['bg', 'StatusLine'],
    \ 'hl':      ['fg', 'Statement'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'],
    \ 'gutter':  ['bg', 'Normal'],
    \ }

let g:fzf_action = {
    \ 'ctrl-q': function('saltor#functions#build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }