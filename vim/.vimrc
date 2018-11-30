highlight CursorLineNR cterm=bold

let g:python_host_prog  = '/usr/bin/python'
let g:ruby_host_prog    = 'rvm system do neovim-ruby-host'

let mapleader = ','

set background=dark
set hidden
set updatetime=100
set splitbelow
set splitright
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set number relativenumber
set ignorecase
set smartcase
set foldenable
set foldlevelstart=10
set foldnestmax=10

source ~/.vim/imports/autocmds.vim
source ~/.vim/imports/plugins.vim
source ~/.vim/imports/mappings.vim
source ~/.vim/imports/coolstuff.vim
