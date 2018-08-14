set background=dark
set hidden

highlight CursorLineNR cterm=bold

let g:python_host_prog  = '/usr/bin/python'

let mapleader = ','
set updatetime=100
set splitbelow
set splitright
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number relativenumber

source ~/.vim/imports/autocmds.vim
source ~/.vim/imports/plugins.vim
source ~/.vim/imports/mappings.vim
source ~/.vim/imports/coolstuff.vim
