if v:progname == 'vi'
    set noloadplugins
endif

filetype indent plugin on " Automatic, language-dependent indentation
syntax on " syntax coloring

let g:mapleader = ','
let g:maplocalleader = '\'

" PLUGINS
set rtp+=$HOME/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
set rtp+=$HOME/.fzf
set rtp+=$HOME/.vim/bundle/LanguageClient-neovim

filetype off

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'    " Package Installer
    Plugin 'chriskempson/base16-vim' " Color schemes
    Plugin 'vim-airline/vim-airline' " Status line
    Plugin 'vim-airline/vim-airline-themes' " Status line theme options
    Plugin 'dense-analysis/ale' " Linter
    Plugin 'junegunn/fzf'         " FZF: A search tool that is fast AF
    Plugin 'junegunn/fzf.vim'     " FZF: FZF for vim
    Plugin 'wellle/targets.vim'   " More text objects and useful manipulations
    Plugin 'tpope/vim-surround'   " Easily add/change/remove surrounding characters
    Plugin 'tpope/vim-repeat'     " Allow repeating of more actions
    Plugin 'Raimondi/delimitMate' " Auto-complete \" \' \( etc.
    Plugin 'tomtom/tcomment_vim'  " Toggle comments
    Plugin 'kassio/neoterm'       " Synchronized terminals
    Plugin 'wincent/terminus'     " Better terminal support
    Plugin 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plugin 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked
    Plugin 'tpope/vim-fugitive'   " Awesome GIT wrapper for VIM
    Plugin 'airblade/vim-gitgutter' " Show changed lines in gutter
    Plugin 'mhinz/vim-startify'   " Start-up screen
    Plugin 'easymotion/vim-easymotion' " Easily navigate around a document

    Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemovePlugins' }
    Plugin 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
    Plugin 'carlitux/deoplete-ternjs'

    Plugin 'scrooloose/nerdtree'  " Visual tree navigation for current folder

    Plugin 'posva/vim-vue'             " Syntax Highlighting for Vim Components
    Plugin 'mxw/vim-jsx'               " Syntax highlighting for JSX
    Plugin 'pangloss/vim-javascript'   " + dependency of vim-jsx (Syntax highlighting for JavaScript)
    Plugin 'hail2u/vim-css3-syntax'    " CSS3 syntax highlighting
    Plugin 'cakebaker/scss-syntax.vim' " SCSS syntax highlighting
    Plugin 'wincent/pinnacle'          " Functions for manipulating highlight groups by userwincent
    Plugin 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

    source $HOME/dotfiles/vim/.vim/plugin/plugins.vim
call vundle#end()

filetype on

augroup Buffers
    autocmd!
    autocmd BufNewFile,BufRead * let g:ale_enabled = 1
    autocmd BufNewFile,BufRead *.email set filetype=html
augroup END

augroup Spelling
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
    autocmd FileType gitcommit setlocal spell spelllang=en_us
    set complete+=kspell
augroup END

augroup Startify
    autocmd!
    autocmd User StartifyReady let g:ale_enabled = 0
augroup END

autocmd ColorScheme * highlight clear SpellBad
autocmd ColorScheme * highlight SpellBad cterm=underline gui=undercurl guibg=#fb4934 guifg=#000000

call saltor#autocomplete#deoplete_init()

" autocmd User ALELintPost call saltor#virtual_text#update_ale_linting()

" When term starts, auto go into insert mode
autocmd TermOpen * startinsert

" Turn off line numbers etc
autocmd TermOpen * setlocal listchars= nonumber norelativenumber
