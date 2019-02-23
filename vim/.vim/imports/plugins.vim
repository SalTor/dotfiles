set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim' " Package Installer

    Plugin 'tpope/vim-repeat'     " Allow repeating of more actions
    Plugin 'tpope/vim-surround'          " Easily add/change/remove surrounding characters. ihello<Esc>ysiw' => 'hello' .. i(hello)<Esc>hcs(' => 'hello'
    Plugin 'tpope/vim-fugitive'   " Awesome GIT wrapper for VIM

    Plugin 'junegunn/fzf'     " FZF: A search tool that is fast AF
    Plugin 'junegunn/fzf.vim' " FZF: FZF for vim

    Plugin 'tommcdo/vim-exchange' " Swap text in a non-manual manner
    Plugin 'terryma/vim-smooth-scroll' " Smooth Scrolling
    Plugin 'wellle/targets.vim'   " More text objects and useful manipulations
    Plugin 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion. `idiv<C+y+,>` => <div></div>
    Plugin 'scrooloose/nerdtree'  " Visual tree navigation for current folder
    Plugin 'machakann/vim-highlightedyank' " Temporarily highlight yanked text, to show what was yanked
    Plugin 'Valloric/YouCompleteMe' " Suggestions as you type
    Plugin 'morhetz/gruvbox'      " Color scheme
    Plugin 'w0rp/ale'             " Linter
    Plugin 'Raimondi/delimitMate'        " Auto-complete \" \' \( etc.
    Plugin 'vim-airline/vim-airline'     " Info bar at bottom of view for line count, cursor position, etc.
    Plugin 'tomtom/tcomment_vim'         " Toggle comments
    Plugin 'wincent/terminus'            " Better terminal support
    Plugin 'airblade/vim-gitgutter'      " Git status of affected lines in the gutter
    Plugin 'mjbrownie/django_completeme' " Auto-completion for django templates
    """ below - syntax
    Plugin 'posva/vim-vue'             " Syntax Highlighting for Vim Components
    Plugin 'pangloss/vim-javascript'   " Syntax highlighting for JavaScript (and 'dependency' of vim-jsx)
    Plugin 'mxw/vim-jsx'               " Syntax highlighting for JSX
    Plugin 'hail2u/vim-css3-syntax'    " CSS3 syntax highlighting
    Plugin 'cakebaker/scss-syntax.vim' " SCSS syntax highlighting
call vundle#end()

colorscheme gruvbox

filetype plugin indent on
syntax enable
