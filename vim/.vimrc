" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
    " Plugin manager, file explorer
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'

    " linting, intellisense
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    " Motions and text objects
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'wellle/targets.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'justinmk/vim-sneak'
    Plug 'unblevable/quick-scope'

    " Auto-complete ([{, auto-complete markup, comments
    Plug 'Raimondi/delimitMate'
    Plug 'mattn/emmet-vim'
    Plug 'preservim/nerdcommenter'

    " Visuals
    Plug 'chriskempson/base16-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'mhinz/vim-startify'
    Plug 'machakann/vim-highlightedyank' " I want to replac ethis with lua, waiting for neovim v0.5.x
    Plug 'psliwka/vim-smoothie'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'wincent/pinnacle' " I wonder if I can get rid of this by reducing the complexity of my color scheme method

    " Navigation aide / visualization
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Terminal aide
    Plug 'kassio/neoterm'
    Plug 'wincent/terminus'

    " Nice to have, don't really need
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'christoomey/vim-system-copy'
    Plug 'christoomey/vim-sort-motion'
    Plug 'godlygeek/tabular'
call plug#end()

source $VIM_PLUG_CONFIG/airline.vim
source $VIM_PLUG_CONFIG/ale.vim
source $VIM_PLUG_CONFIG/easymotion.vim
source $VIM_PLUG_CONFIG/fzf.vim
source $VIM_PLUG_CONFIG/nerdcommenter.vim
source $VIM_PLUG_CONFIG/nerdtree.vim
source $VIM_PLUG_CONFIG/nvim-colorizer.lua
source $VIM_PLUG_CONFIG/quickscope.vim
source $VIM_PLUG_CONFIG/sneak.vim
source $VIM_PLUG_CONFIG/startify.vim
source $VIM_PLUG_CONFIG/which-key.vim
