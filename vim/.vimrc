set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'mattn/emmet-vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'jistr/vim-nerdtree-tabs'
    Plugin 'posva/vim-vue'
    Plugin 'ervandew/supertab'
    Plugin 'morhetz/gruvbox'
call vundle#end()


syntax enable
filetype plugin indent on

set background=dark
colorscheme gruvbox

autocmd InsertLeave * if expand('%') != '' | update | endif

hi CursorLineNR cterm=bold
augroup CLNRSet
    set cursorline
    autocmd! ColorScheme * hi CursorLineNR cterm=bold
augroup END

let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
autocmd VimLeave * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

map <C-n> :NERDTreeToggle<CR>

no <down> ddp
no <left> <Nop>
no <right> <Nop>
no <up> ddkP

ino <down> <ESC>ddpi
ino <left> <Nop>
ino <right> <Nop>
ino <up> <ESC>ddkPi

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>
