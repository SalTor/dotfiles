if v:progname == 'vi'
    set noloadplugins
endif

filetype indent plugin on " Automatic, language-dependent indentation
syntax on " syntax coloring

set directory^=$HOME/.vim/nvim/tmp//

" PLUGINS
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    set rtp+=~/.fzf

    filetype off

    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim' " Package Installer
    Plugin 'chriskempson/base16-vim'

    Plugin 'tpope/vim-repeat'     " Allow repeating of more actions
    Plugin 'tpope/vim-surround'   " Easily add/change/remove surrounding characters
    Plugin 'tpope/vim-fugitive'   " Awesome GIT wrapper for VIM

    Plugin 'junegunn/fzf'     " FZF: A search tool that is fast AF
    Plugin 'junegunn/fzf.vim' " FZF: FZF for vim

    Plugin 'tommcdo/vim-exchange' " Swap text in a non-manual manner
    Plugin 'terryma/vim-smooth-scroll' " Smooth Scrolling
    Plugin 'wellle/targets.vim'   " More text objects and useful manipulations
    Plugin 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion
    Plugin 'scrooloose/nerdtree'  " Visual tree navigation for current folder
    Plugin 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked
    Plugin 'JamshedVesuna/vim-markdown-preview' " Preview Markdown files in browser
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'w0rp/ale'                    " Linter
    Plugin 'Raimondi/delimitMate'        " Auto-complete \" \' \( etc.
    Plugin 'tomtom/tcomment_vim'         " Toggle comments
    Plugin 'wincent/terminus'            " Better terminal support
    Plugin 'kassio/neoterm'
    Plugin 'airblade/vim-gitgutter'      " Git status of affected lines in the gutter
    Plugin 'mjbrownie/django_completeme' " Auto-completion for django templates
    Plugin 'vim-airline/vim-airline'     " Status line
    Plugin 'vim-airline/vim-airline-themes' " Status line theme options

    Plugin 'mhinz/vim-startify' " Start-up screen

    " Syntax
        Plugin 'posva/vim-vue'             " Syntax Highlighting for Vim Components
        Plugin 'pangloss/vim-javascript'   " Syntax highlighting for JavaScript (and 'dependency' of vim-jsx)
        Plugin 'mxw/vim-jsx'               " Syntax highlighting for JSX
        Plugin 'hail2u/vim-css3-syntax'    " CSS3 syntax highlighting
        Plugin 'cakebaker/scss-syntax.vim' " SCSS syntax highlighting
        Plugin 'wincent/pinnacle'          " Functions for manipulating highlight groups by userwincent
    call vundle#end()

    filetype on

" Language settings
    " JavaScript settings
        let s:js_filetypes=[
        \   'javascript',
        \   'javascript.jsx',
        \   'javascript.jest',
        \   'javascript.jest.jsx'
        \ ]

    " Python settings
        let b:ale_linters=['pyflakes']
        let b:ale_warn_about_trailing_whitespace=0
        let b:ale_lint_on_enter=1
        let b:pymode_python='python3'

        let g:python_host_prog = '/usr/bin/python'
        let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'
