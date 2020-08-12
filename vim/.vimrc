" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')
    " Plugin manager
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'

    " Motions and text objects
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'wellle/targets.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'christoomey/vim-system-copy'
    Plug 'christoomey/vim-sort-motion'

    " Linting, LSP, git
    Plug 'dense-analysis/ale'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'tpope/vim-fugitive', { 'on': ['Gdiff', 'Gblame', 'Glog'] }

    " Snippets
    Plug 'honza/vim-snippets'
    Plug 'Raimondi/delimitMate'
    Plug 'mattn/emmet-vim'
    Plug 'preservim/nerdcommenter'

    " Terminal aide
    Plug 'kassio/neoterm'
    Plug 'wincent/terminus'

    " REPL
    Plug 'jpalardy/vim-slime'

    " Navigation aide / visualization
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'airblade/vim-gitgutter', { 'on': ['GitGutterToggle','GitGutterEnable'] }

    " Visuals
    Plug 'sheerun/vim-polyglot'
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'mhinz/vim-startify'
    Plug 'chriskempson/base16-vim'
    Plug 'wincent/pinnacle'
    Plug 'RRethy/vim-illuminate', { 'on': ['IlluminationToggle', 'IlluminationEnable'] }
    Plug 'mhartington/oceanic-next'
    Plug 'othree/yajs.vim'
    Plug 'machakann/vim-highlightedyank'
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()
