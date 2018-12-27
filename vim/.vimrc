highlight CursorLineNR cterm=bold

let g:python_host_prog  = '/usr/bin/python'
let g:ruby_host_prog    = 'rvm system do neovim-ruby-host'

let mapleader = ','

set background=dark
set directory^=$HOME/.vim/nvim/tmp//
set foldenable
set foldlevelstart=10
set foldnestmax=10
set hidden
set ignorecase
set inccommand=split
set number relativenumber
set smartcase
set splitbelow
set splitright
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set updatetime=100

source ~/.vim/imports/autocmds.vim
source ~/.vim/imports/plugins.vim
source ~/.vim/imports/mappings.vim
source ~/.vim/imports/coolstuff.vim
