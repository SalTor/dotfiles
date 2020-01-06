let s:deoplete_init_done=0
function! saltor#autocomplete#deoplete_init() abort
    if s:deoplete_init_done || !has('nvim')
        return
    endif

    let s:deoplete_init_done=1

    let g:deoplete#max_list=25
    let g:deoplete#auto_refresh_delay=0

    call deoplete#enable()

    call deoplete#custom#option({ 'smart_case': v:true })
    call deoplete#custom#source('ultisnips', 'rank', 1000)
    call deoplete#custom#source('member', 'rank', 300)
    call deoplete#custom#source('LanguageClient', 'rank', 200)
    call deoplete#custom#source('around', 'rank', 0)
    call deoplete#custom#source('buffer', 'rank', 100)
    call deoplete#custom#source('file', 'rank', 50)
    call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
endfunction
