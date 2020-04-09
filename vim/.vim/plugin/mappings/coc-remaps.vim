inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ saltor#functions#check_back_space() ? "\<TAB>" :
    \ coc#refresh()

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" coc.nvim
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
nmap <Leader>vr <Plug>(coc-rename)
nmap [e <Plug>(ale_previous_wrap)
nmap ]e <Plug>(ale_next_wrap)
