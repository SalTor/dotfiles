" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Plugin manager, file explorer
    Plug 'junegunn/vim-plug'
    " Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    " Plug 'junegunn/fzf.vim'

    " Motions and text objects
    " Plug 'tpope/vim-repeat'
    " Plug 'tpope/vim-surround'
    " Plug 'wellle/targets.vim'
    " Plug 'easymotion/vim-easymotion'
    Plug 'RRethy/nvim-base16'

    " Auto-complete ([{, auto-complete markup, comments
    " Plug 'Raimondi/delimitMate'
    " Plug 'mattn/emmet-vim'
    " Plug 'preservim/nerdcommenter'

    " Visuals
    " Plug 'neoclide/jsonc.vim'
    " Plug 'liuchengxu/vim-which-key'
    " Plug 'mhinz/vim-startify'
    " Plug 'psliwka/vim-smoothie'
    " Plug 'norcalli/nvim-colorizer.lua'
    " Plug 'wincent/pinnacle' " I wonder if I can get rid of this by reducing the complexity of my color scheme method
    " Plug 'sheerun/vim-wombat-scheme'
    " Plug 'kyazdani42/nvim-web-devicons'
    " Plug 'kosayoda/nvim-lightbulb'

    " Navigation aide / visualization
    " Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'

    " Terminal aide
    " Plug 'kassio/neoterm'
    " Plug 'wincent/terminus'

    " Snippets
    " Plug 'honza/vim-snippets'

    " Nice to have, don't really need
    " Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    " Plug 'christoomey/vim-system-copy'

    " Intellisense
    " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Plug 'nvim-lua/popup.nvim'
    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'nvim-telescope/telescope.nvim'
    " Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " Plug 'neovim/nvim-lspconfig'
    " Plug 'hrsh7th/nvim-compe'
    " Plug 'glepnir/lspsaga.nvim'
    " Plug 'mattn/efm-langserver'
call plug#end()
