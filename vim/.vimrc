" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'junegunn/vim-plug' " Package Installer
    Plug 'chriskempson/base16-vim' " Color schemes
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Status line theme options
    Plug 'dense-analysis/ale' " Linter
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' } " FZF: A search tool that is fast AF
    Plug 'junegunn/fzf.vim'     " FZF: FZF for vim
    Plug 'wellle/targets.vim'   " More text objects and useful manipulations
    Plug 'tpope/vim-surround'   " Easily add/change/remove surrounding characters
    Plug 'tpope/vim-repeat'     " Allow repeating of more actions
    Plug 'Raimondi/delimitMate' " Auto-complete \" \' \( etc.
    Plug 'preservim/nerdcommenter' " Control code-comments
    Plug 'kassio/neoterm'       " Synchronized terminals
    Plug 'wincent/terminus'     " Better os-terminal support
    Plug 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked
    Plug 'tpope/vim-fugitive'     " Awesome GIT wrapper for VIM
    Plug 'airblade/vim-gitgutter' " Show changed lines in gutter
    Plug 'mhinz/vim-startify'     " Start-up screen
    Plug 'google/vim-searchindex' " Show search index on the left, not sure if vim's default right-side one can be moved
    Plug 'tpope/vim-repeat'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'honza/vim-snippets'
    Plug 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plug 'sheerun/vim-polyglot' " Syntax files for most languages
    Plug 'scrooloose/nerdtree', " Visual tree navigation
        \ {
        \ 'on': [
        \    'NERDTreeToggle',
        \    'NERDTreeFind',
        \    'NERDTreeFocus',
        \    'NERDTreeClose',
        \    'NERDTreeFocus'
        \ ] }
    Plug 'easymotion/vim-easymotion' " Easily navigate around a document
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Show colors as virtual text or gutter, your choice
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Display leader/local leader mappings
    Plug 'junegunn/goyo.vim' " Focused writing

    Plug 'wincent/pinnacle' " Functions for manipulating highlight groups by userwincent

    Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' } " Choose window/split visually

    Plug 'tweekmonster/fzf-filemru' " MRU applied with fzf

    source $HOME/dotfiles/vim/.vim/plugin/plugins.vim
call plug#end()
