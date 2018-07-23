set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'tpope/vim-fugitive'
    Plugin 'mattn/emmet-vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'posva/vim-vue'
    Plugin 'ervandew/supertab'
    Plugin 'morhetz/gruvbox'
    Plugin 'easymotion/vim-easymotion'
    Plugin 'Raimondi/delimitMate'
    Plugin 'Yggdroot/indentLine'
    Plugin 'vim-airline/vim-airline'
    Plugin 'tpope/vim-surround'
    Plugin 'tomtom/tcomment_vim'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'
    Plugin 'wincent/terminus'
    Plugin 'vim-scripts/indentpython.vim'
    Plugin 'hail2u/vim-css3-syntax'
    Plugin 'cakebaker/scss-syntax.vim'
    Plugin 'airblade/vim-gitgutter'
call vundle#end()

autocmd VimEnter * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
autocmd VimLeave * silent !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

colorscheme gruvbox


" PLUGIN SETTINGS  
    let g:indentLine_setColors = 1

    let g:fzf_layout={ 'down': '~30%' }

    let g:airline#extensions#tabline#enabled=1
" PLUGIN SETTINGS


filetype plugin indent on
syntax enable
