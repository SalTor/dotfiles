syntax on
filetype indent plugin on

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"

set noswapfile
set hidden
set clipboard=unnamed

set noshowmode
set shiftwidth=4
set expandtab
set shiftround
set spelllang=en_us

set ignorecase
set smartcase
set inccommand=split
set noshowmatch
set hlsearch
set gdefault

set number
set cursorline
set scrolloff=3

set timeoutlen=500

set shortmess+=a
set shortmess+=c

set formatoptions+=j
set formatoptions+=n
set formatoptions-=o

set directory^=$HOME/.vim/nvim/tmp//

set splitbelow
set splitright
set nojoinspaces
set listchars=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set fillchars+=eob:\ 

set breakindent
set breakindentopt=shift:4

set foldlevelstart=50
set foldopen-=block
set foldmethod=indent
set foldtext=saltor#settings#foldtext()
set virtualedit=block

let g:python_host_prog = '/usr/bin/python'
let g:pymode_python = 'python3'
let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

let g:js_filetypes=[
\   'javascript',
\   'javascript.jsx',
\   'javascript.jest',
\   'javascript.jest.jsx'
\ ]

highlight Comment cterm=italic gui=italic
