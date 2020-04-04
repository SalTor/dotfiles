syntax on
filetype indent plugin on

set nobackup nowritebackup
set undofile undodir=~/.vim/undodir
set noerrorbells novisualbell
set clipboard=unnamed
set lazyredraw
set noshowmatch matchtime=2
set nojoinspaces
set wildmenu

set spelllang=en_us
set noshowmode
set noruler

set expandtab smarttab shiftwidth=4 tabstop=4 softtabstop=4 shiftround
set number
set cursorline
set scrolloff=3
set backspace=start,eol,indent
set whichwrap+=<,>,h,l

set list listchars=tab:>-,nbsp:⦸,extends:»,precedes:«,trail:•

set autoindent smartindent wrap
set breakindent breakindentopt=shift:4
set foldtext=saltor#settings#foldtext() foldlevelstart=50 foldopen-=block foldmethod=indent
set virtualedit=block

set ignorecase smartcase incsearch hlsearch
set inccommand=split

set splitbelow splitright
set hidden

set timeoutlen=500
set updatetime=300

set shortmess+=a
set formatoptions+=jn

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:pymode_python = 'python3'
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

let g:js_filetypes=[
\   'javascript',
\   'javascript.jsx',
\   'javascript.jest',
\   'javascript.jest.jsx'
\ ]
