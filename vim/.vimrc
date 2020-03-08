" PLUGINS
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
    Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " Display leader/local leader mappings
    Plug 'junegunn/vim-plug' " Package Installer
    Plug 'junegunn/fzf', { 'do': 'yes \| ./install' } " FZF: A search tool that is fast AF
    Plug 'junegunn/fzf.vim'   " FZF: FZF for vim
    Plug 'junegunn/goyo.vim'  " Focused writing
    Plug 'tpope/vim-fugitive' " Awesome GIT wrapper for VIM
    Plug 'tpope/vim-surround' " Easily add/change/remove surrounding characters
    Plug 'tpope/vim-repeat'   " Allow repeating of more actions
    Plug 'mhinz/vim-startify' " Start-up screen
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind', 'NERDTreeFocus', 'NERDTreeClose', 'NERDTreeFocus' ] }
    Plug 'Raimondi/delimitMate' " Auto-complete opening and closing braces and the like
    Plug 'easymotion/vim-easymotion' " Easily navigate around a document
    Plug 'airblade/vim-gitgutter'  " Show changed lines in gutter
    Plug 'sheerun/vim-polyglot'    " Syntax files for most languages
    Plug 'preservim/nerdcommenter' " Control code-comments

    Plug 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " Show colors as virtual text or gutter, your choice
    Plug 'dense-analysis/ale' " Linter
    Plug 'honza/vim-snippets'
    Plug 'kassio/neoterm'       " Synchronized terminals
    Plug 'wincent/terminus'     " Better os-terminal support
    Plug 't9md/vim-choosewin', { 'on': '<Plug>(choosewin)' } " Choose window/split visually

    Plug 'wincent/pinnacle' " Functions for manipulating highlight groups by userwincent
    Plug 'chriskempson/base16-vim' " Color schemes
    Plug 'vim-airline/vim-airline' " Status line
    Plug 'vim-airline/vim-airline-themes' " Status line theme options
    Plug 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked

    Plug 'tweekmonster/fzf-filemru' " MRU applied with fzf

    source $HOME/dotfiles/vim/.vim/plugin/plugins.vim
call plug#end()
