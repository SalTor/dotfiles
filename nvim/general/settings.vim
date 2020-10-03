let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'

if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
filetype indent plugin on

set nobackup nowritebackup noswapfile
set undofile undodir=~/.config/nvim/undodir
set noerrorbells novisualbell belloff=all
set noshowmatch
set wildmenu

set lazyredraw

set spelllang=en_us
set noshowmode noshowcmd noruler

set expandtab smarttab shiftwidth=4 tabstop=4 softtabstop=4 shiftround
set number
set cursorline
set scrolloff=3
set backspace=start,eol,indent
set whichwrap=""

set list listchars=tab:>-,nbsp:⦸,extends:»,precedes:«,trail:•

let &showbreak='⤷ '
set breakindent breakindentopt=shift:2
set autoindent smartindent wrap
set foldtext=saltor#settings#foldtext() foldlevelstart=50 foldopen-=block foldmethod=indent
set virtualedit=block

set ignorecase smartcase incsearch hlsearch
set inccommand=split

set splitbelow splitright           " :vsp puts you on right; :sp puts you below
set hidden                          " change buffer even if has unsaved changes
set switchbuf=usetab                " try to reuse windows/tabs when switching buffers

set timeoutlen=500                  " time in milliseconds to wait for a mapped sequence to complete
set updatetime=300                  " duration for CursorHold autocmd

set shortmess+=A                    " ignore annoying swapfile messages
set shortmess+=I                    " hide splash screen
set shortmess+=O                    " file-read message overwrites previous
set shortmess+=T                    " truncate non-file messages in middle
set shortmess+=W                    " don't echo [written] when writing
set shortmess+=a                    " use abbreciations eg `[RO] instead of `[readonly]`
set shortmess+=o                    " overwrite file-written messages
set shortmess+=t                    " truncate file messages at start
set shortmess+=c                    " don't give ins-completion-menu messages

set formatoptions+=n                " when formatting text, recognize numbered lists
set formatoptions+=j                " remove comment leader when joining
set nojoinspaces                    " remove duplicate space when joining

set completeopt-=preview            " don't use split preview for completion
