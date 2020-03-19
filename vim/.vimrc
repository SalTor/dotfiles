" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
    Plug 'junegunn/vim-plug'
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/goyo.vim' " Focused writing followed by more focused writing by fading unfocused text
    Plug 'junegunn/limelight.vim'
    Plug 'tpope/vim-fugitive' " Awesome GIT wrapper for VIM
    Plug 'tpope/vim-surround' " Easily add/change/remove surrounding characters
    Plug 'tpope/vim-repeat'   " Allow repeating of more actions
    Plug 'wellle/targets.vim' " Additional text objects
    Plug 'mhinz/vim-startify' " Start-up screen
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'Raimondi/delimitMate' " Auto-complete opening and closing braces and the like
    Plug 'easymotion/vim-easymotion' " Easily navigate around a document
    Plug 'airblade/vim-gitgutter'  " Show changed lines in gutter
    Plug 'preservim/nerdcommenter' " Control code-comments
    Plug 'sheerun/vim-polyglot'    " Syntax files for most languages

    Plug 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plug 'dense-analysis/ale' " Linter
    Plug 'honza/vim-snippets' " Snippets solution that works better with coc.nvim
    Plug 'kassio/neoterm'     " Synchronized terminals
    Plug 'wincent/terminus'   " Better os-terminal support

    Plug 'wincent/pinnacle' " Functions for manipulating highlight groups by userwincent
    Plug 'chriskempson/base16-vim' " Color schemes
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Status line theme options
    Plug 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked

    Plug 'jpalardy/vim-slime'

    Plug 'RRethy/vim-illuminate'
    Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
