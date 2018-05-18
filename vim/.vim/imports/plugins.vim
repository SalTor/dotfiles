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
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    Plugin 'posva/vim-vue'
    Plugin 'ervandew/supertab'
    Plugin 'morhetz/gruvbox'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'Raimondi/delimitMate'
    Plugin 'Yggdroot/indentLine'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'vim-airline/vim-airline'
    Plugin 'tpope/vim-surround'
    Plugin 'tomtom/tcomment_vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'
call vundle#end()

set rtp+=~/.fzf

autocmd VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
autocmd VimLeave * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

colorscheme gruvbox

let g:indentLine_setColors = 1
let g:gitgutter_terminal_reports_focus=0
let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_autofind=1

filetype plugin indent on
syntax enable
