function! saltor#capsule#setup()
    setlocal tabstop=2 shiftwidth=2
    let g:vim_markdown_new_list_item_indent = 2
endfunction

function! saltor#capsule#whitespace()
    let b:notrim_whitespace = 1
endfunction
