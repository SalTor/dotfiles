let s:deoplete_init_done=0
function! saltor#autocomplete#deoplete_init() abort
    if s:deoplete_init_done || !has('nvim')
        return
    endif

    let s:deoplete_init_done=1

    let g:deoplete#max_list=15

    call deoplete#enable()

    call deoplete#custom#option({ 'smart_case': v:true })
    call deoplete#custom#source('member', 'rank', 300)
    call deoplete#custom#source('around', 'rank', 0)
    call deoplete#custom#source('buffer', 'rank', 100)
    call deoplete#custom#source('file', 'rank', 50)
    call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy', 'matcher_length'])

    " Set bin if you have many instalations
    let g:deoplete#sources#ternjs#tern_bin = exepath('tern')
    let g:deoplete#sources#ternjs#timeout = 1

    "Add extra filetypes
    let g:deoplete#sources#ternjs#filetypes = [
        \ 'jsx',
        \ 'javascript.jsx',
        \ 'vue',
        \ '...'
        \ ]
endfunction
