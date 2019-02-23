highlight CursorLineNR cterm=bold

let g:python_host_prog = '/usr/bin/python'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

let mapleader = ','

set background=dark
set directory^=$HOME/.vim/nvim/tmp//
set hidden

" Shared Clipboard:
set clipboard=unnamed

" Folding:
set foldenable
set foldlevelstart=10
set foldnestmax=10

" Global Line Numbers And Relative Line Number For Normal Mode
set number relativenumber

" Search Case Insensitive Until Uppercase Used:
set ignorecase
set smartcase

" Split Prioritization:
set splitbelow
set splitright

" NVIM Create Split To Preview Search And Replace Effects On Lines Out Of Sight:
set inccommand=split

" Tabs Instead Of Spaces:
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Delay For Swap File Writes:
set updatetime=100

source ~/.vim/imports/autocmds.vim
source ~/.vim/imports/plugins.vim
source ~/.vim/imports/mappings.vim
source ~/.vim/imports/coolstuff.vim
