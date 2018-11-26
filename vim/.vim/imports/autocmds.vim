autocmd BufRead,BufNewFile *.css,*.scss set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd BufRead,BufNewFile *.json set conceallevel=0

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

augroup CLNRSet
    set cursorline
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END
