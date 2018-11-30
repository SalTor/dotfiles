set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf

call vundle#begin()
    Plugin 'VundleVim/Vundle.vim' " Package Installer
    Plugin 'wellle/targets.vim'   " More text objects and useful manipulations
    Plugin 'tpope/vim-fugitive'   " Awesome GIT wrapper for VIM
    Plugin 'mattn/emmet-vim'      " Enable dom-element 'tab-esque' completion. `idiv<C+y+,>` => <div></div>
    Plugin 'scrooloose/nerdtree'  " Visual tree navigation for current folder
    Plugin 'Valloric/YouCompleteMe' " Suggestions as you type
    Plugin 'morhetz/gruvbox'      " Color scheme
    Plugin 'w0rp/ale'             " Linter
    Plugin 'easymotion/vim-easymotion'   " Move around file more easily
    Plugin 'Raimondi/delimitMate'        " Auto-complete \" \' \( etc.
    Plugin 'Yggdroot/indentLine'         " Display indentations as gray, vertical lines
    Plugin 'vim-airline/vim-airline'     " Info bar at bottom of view for line count, cursor position, etc.
    Plugin 'tpope/vim-surround'          " Easily add/change/remove surrounding characters. ihello<Esc>ysiw' => 'hello' .. i(hello)<Esc>hcs(' => 'hello'
    Plugin 'tomtom/tcomment_vim'         " Toggle comments
    Plugin 'junegunn/fzf'                " FZF: A search tool that is fast AF
    Plugin 'junegunn/fzf.vim'            " FZF: FZF for vim
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

" PLUGIN SETTINGS
    let g:indentLine_setColors = 1

    let g:airline#extensions#tabline#enabled=1
    let g:airline#extensions#ale#enabled=1

    let g:ale_lint_delay=0
    let g:ale_lint_on_enter=1
    let g:ale_lint_on_save=1
    let g:ale_lint_on_text_changed=1
    let g:ale_lint_on_insert_leave=1
    let g:ale_completion_enabled=1
    let g:ale_fixers = {'javascript': 'eslint', 'javascript.jsx': 'eslint'}

    " FZF
    " Sane default for :Ag usage to not match folder/file names
    let s:__fzf_ag_options='--only-matching'
    command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, s:__fzf_ag_options, fzf#vim#with_preview('right:50%', '?'))
    command! -bang -nargs=? GFiles
      \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
    command! -bang -nargs=? Buffers
      \ call fzf#vim#buffers(<q-args>, fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1
    let g:fzf_layout={ 'down': '~40%' }
" PLUGIN SETTINGS


filetype plugin indent on
syntax enable
