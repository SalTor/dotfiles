" PLUGINS
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Plugin manager, file explorer
    Plug 'junegunn/vim-plug'

    " Motions and text objects
    Plug 'wellle/targets.vim' " - include ([{,< as text objects like ci(
    Plug 'tpope/vim-surround' " - interact with surrounding ([{ etc
    Plug 'justinmk/vim-sneak' " - jump to any location with 2 letters

    " File explorer
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'mhinz/vim-startify' " - bookmarks / Most Recently Used

    " Auto-complete ([{, auto-complete markup, comments
    Plug 'Raimondi/delimitMate'    " -
    Plug 'mattn/emmet-vim'         " -
    Plug 'preservim/nerdcommenter' " -

    " Util
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'

    " Intellisense
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'mattn/efm-langserver'
    Plug 'hrsh7th/nvim-compe'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'

    " Terminal aide
    Plug 'kassio/neoterm'
    Plug 'wincent/terminus'

    " Visuals
    Plug 'RRethy/nvim-base16' " - Color schemes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'sheerun/vim-wombat-scheme'

    " Nice to have
    Plug 'christoomey/vim-system-copy'  " -
    Plug 'neoclide/jsonc.vim'           " - jsonc for json with comments
    Plug 'psliwka/vim-smoothie'         " - smooth scrolling
    Plug 'liuchengxu/vim-which-key'     " - show leader keymappings
    Plug 'norcalli/nvim-colorizer.lua'  " - preview colors
    Plug 'kyazdani42/nvim-web-devicons' " - icons everywhere
    Plug 'kosayoda/nvim-lightbulb'      " - indicate code-actions with lightbulb
    Plug 'wincent/pinnacle'             " - I wonder if I can get rid of this by reducing the complexity of my color scheme method
call plug#end()
