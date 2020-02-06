let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

if has('autocmd')
    augroup SalTorAutocomplete
        autocmd!
        autocmd! User UltiSnipsEnterFirstSnippet
        autocmd User UltiSnipsEnterFirstSnippet call saltor#autocomplete#setup_mappings()
        autocmd! User UltiSnipsExitLastSnippet
        autocmd User UltiSnipsExitLastSnippet call saltor#autocomplete#teardown_mappings()
    augroup END
endif

" Additional UltiSnips config.
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/Ultisnips'
let g:UltiSnipsSnippetDirectories = [
    \ $HOME . '/.vim/Ultisnips',
    \ $HOME . '/.vim/ultisnips-private'
    \ ]

if has('nvim')
    call saltor#autocomplete#deoplete_init()

    inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
    inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
    inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
