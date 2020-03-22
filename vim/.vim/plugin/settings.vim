syntax on
filetype indent plugin on

set spelllang=en_us
set noshowmode
set noshowmatch
set noswapfile nobackup
set undofile undodir=~/.vim/undodir
set nojoinspaces
set noerrorbells
set clipboard=unnamed

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab shiftround
set number
set cursorline
set scrolloff=3

set list listchars=tab:>-,nbsp:⦸,extends:»,precedes:«,trail:•

set breakindent breakindentopt=shift:4
set foldtext=saltor#settings#foldtext() foldlevelstart=50 foldopen-=block foldmethod=indent
set virtualedit=block

set ignorecase smartcase incsearch hlsearch
set inccommand=split

set splitbelow splitright
set hidden

set timeoutlen=500
set updatetime=100

set shortmess+=a
set formatoptions+=jn

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:pymode_python = 'python3'
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

let g:js_filetypes=[
\   'javascriptreact',
\   'javascript',
\   'javascript.jsx',
\   'javascript.jest',
\   'javascript.jest.jsx'
\ ]
