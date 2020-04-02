" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive', { 'on': ['Gdiff', 'Gblame', 'Glog'] } " Awesome GIT wrapper for VIM
    Plug 'tpope/vim-surround' " Easily add/change/remove surrounding characters
    Plug 'tpope/vim-repeat'   " Allow repeating of more actions
    Plug 'wellle/targets.vim' " Additional text objects
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'mhinz/vim-startify' " Start-up screen
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'Raimondi/delimitMate' " Auto-complete opening and closing braces and the like
    Plug 'easymotion/vim-easymotion' " Easily navigate around a document
    Plug 'airblade/vim-gitgutter', { 'on': ['GitGutterToggle','GitGutterEnable'] } " Show changed lines in gutter
    Plug 'preservim/nerdcommenter' " Control code-comments
    Plug 'sheerun/vim-polyglot'    " Syntax files for most languages
    Plug 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plug 'dense-analysis/ale'   " Async update linting warnings inside VIM
    Plug 'honza/vim-snippets'   " Snippets solution that works better with coc.nvim
    Plug 'kassio/neoterm'       " Synchronized terminals
    Plug 'wincent/terminus'     " Better os-terminal support
    Plug 'chriskempson/base16-vim' " Color schemes
    Plug 'wincent/pinnacle' " Functions for manipulating highlight groups by userwincent
    Plug 'vim-airline/vim-airline' " Status line toolset
    Plug 'vim-airline/vim-airline-themes' " Airline theme options
    Plug 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked
    Plug 'jpalardy/vim-slime' " REPL integration
    Plug 'RRethy/vim-illuminate' ", { 'on': ['IlluminationToggle', 'IlluminationEnable'] } Highlight variable under cursor
    Plug 'norcalli/nvim-colorizer.lua' " Give 'red' a guibg of red, etc.

    Plug 'unblevable/quick-scope'
    Plug 'AndrewRadev/splitjoin.vim'
call plug#end()
