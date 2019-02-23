if v:progname == 'vi'
  set noloadplugins
endif

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

let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#ale#enabled=1

let g:ale_lint_delay=0
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=1
let g:ale_lint_on_insert_leave=1
let g:ale_completion_enabled=1
let g:ale_fixers = {'javascript': 'eslint', 'javascript.jsx': 'eslint'}

let g:fzf_buffers_jump = 1 " Jump to the existing window if possible
let g:fzf_layout={ 'down': '~40%' }

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit',
    \ 'enter': 'tab split' }

let g:NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

source $HOME/.vim/imports/plugins.vim
source $HOME/.vim/imports/commands.vim
