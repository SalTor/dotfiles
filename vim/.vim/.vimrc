if v:progname == 'vi'
  set noloadplugins
endif

" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
filetype indent plugin on
syntax on

let mapleader="\,"
let maplocalleader="\\"

let s:js_filetypes=[
      \   'javascript',
      \   'javascript.jsx',
      \   'javascript.jest',
      \   'javascript.jest.jsx'
      \ ]

let g:python_host_prog = '/usr/bin/python'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

set directory^=$HOME/.vim/nvim/tmp//

source $HOME/.vim/imports/plugins.vim
source $HOME/.vim/imports/commands.vim
