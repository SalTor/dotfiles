" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Plugin manager, file explorer
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'

    " linting, intellisense
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }

    " Motions and text objects
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'wellle/targets.vim'
    Plug 'easymotion/vim-easymotion'

    " Auto-complete ([{, auto-complete markup, comments
    Plug 'Raimondi/delimitMate'
    Plug 'mattn/emmet-vim'
    Plug 'preservim/nerdcommenter'

    " Visuals
    Plug 'chriskempson/base16-vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'neoclide/jsonc.vim'
    Plug 'liuchengxu/vim-which-key'
    Plug 'mhinz/vim-startify'
    Plug 'psliwka/vim-smoothie'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'wincent/pinnacle' " I wonder if I can get rid of this by reducing the complexity of my color scheme method
    Plug 'sheerun/vim-wombat-scheme'

    " Navigation aide / visualization
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Terminal aide
    Plug 'kassio/neoterm'
    Plug 'wincent/terminus'

    " Snippets
    Plug 'honza/vim-snippets'

    " Nice to have, don't really need
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'christoomey/vim-system-copy'

    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
