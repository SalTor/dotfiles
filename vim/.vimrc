if v:progname == 'vi'
    set noloadplugins
endif

" PLUGINS
set rtp+=$HOME/.vim/bundle/LanguageClient-neovim

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

    Plug 'mattn/emmet-vim'        " Enable dom-element 'tab-esque' completion
    Plug 'mxw/vim-jsx', { 'for': 'javascript.jsx' } " Syntax highlighting for JSX
    Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] } " + dependency of vim-jsx (Syntax highlighting for JavaScript)
    Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'sass', 'scss'] } " CSS3 syntax highlighting
    Plug 'cakebaker/scss-syntax.vim', { 'for': ['sass', 'scss'] } " SCSS syntax highlighting

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemovePlugins' } " Typing completion engine
    Plug 'carlitux/deoplete-ternjs' " Ternjs source for deoplete
    Plug 'autozimu/LanguageClient-neovim', " Language Server Protocol plugin for connecting to code completion of various languages
        \ { 'branch': 'next', 'do': 'bash install.sh' }

    " Visual tree navigation
    Plug 'scrooloose/nerdtree', {
        \ 'on': [
        \    'NERDTreeToggle',
        \    'NERDTreeFind',
        \    'NERDTreeFocus',
        \    'NERDTreeClose',
        \    'NERDTreeFocus'
        \ ] }

    Plug 'easymotion/vim-easymotion' " Easily navigate around a document
    " Plug 'sirver/UltiSnips' " Snippets tool

    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Show colors as virtual text or gutter, your choice

    Plug 'wincent/pinnacle' " Functions for manipulating highlight groups by userwincent

    source $HOME/dotfiles/vim/.vim/plugin/plugins.vim
call plug#end()
