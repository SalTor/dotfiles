" Insert mode line-movements
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A

" Go through popup menu
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
