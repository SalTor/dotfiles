augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup CLNRSet
    set cursorline
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

autocmd BufRead,BufNewFile *.css,*.scss set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab foldmethod=syntax

autocmd BufRead,BufNewFile *.json set conceallevel=0
augroup javascript_css_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

augroup python_folding
    au!
    au FileType python setlocal foldmethod=indent
augroup END
