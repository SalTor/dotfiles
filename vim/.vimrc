set background=dark
set hidden

autocmd InsertLeave * if expand('%') != '' | update | endif

hi CursorLineNR cterm=bold
augroup CLNRSet
    set cursorline
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let mapleader = ','

source ~/.vim/imports/plugins.vim
source ~/.vim/imports/mappings.vim
