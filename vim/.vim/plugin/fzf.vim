function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction

let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
let g:fzf_action = {
    \ 'ctrl-q': function('s:build_quickfix_list'),
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=? Rg call saltor#functions#FormatRipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* DynamicRg call saltor#functions#DynamicRipgrepFzf(<q-args>, <bang>0)
