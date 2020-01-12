let s:ns_id = nvim_create_namespace('sal')

function! saltor#virtual_text#update_ale_linting()
    for val in ale#engine#GetLoclist(bufnr(''))
        call nvim_buf_set_virtual_text(val.bufnr, s:ns_id, val.lnum-1, [[val.text]], {})
    endfor
endfunction

function! saltor#virtual_text#clear()
    call nvim_buf_clear_highlight(bufnr(''), s:ns_id, 0, -1)
endfunction
