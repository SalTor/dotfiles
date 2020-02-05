let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
let g:fzf_action = {
    \ 'ctrl-q': function('saltor#functions#build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }
