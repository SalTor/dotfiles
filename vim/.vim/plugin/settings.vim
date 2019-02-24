highlight CursorLineNR cterm=bold

set background=dark

set autoindent                    " maintain indent of current line
set backspace=indent,start,eol    " allow unrestricted backspacing in insert mode

" Shared Clipboard:
set clipboard=unnamed

if exists('&belloff')
    set belloff=all
endif

" Folding:
if has('folding')
    if has('windows')
        set fillchars=vert:┃
        set fillchars+=fold:·
    endif
    set foldmethod=indent
    set foldlevelstart=50
    set foldtext=saltor#settings#foldtext()
endif

if has('linebreak')
    set breakindent
    if exists('&breakindentopt')
        set breakindentopt=shift:4
    endif
endif

if exists('+colorcolumn')
    " Highlight up to 255 columns (this is the current Vim mxa) beyond 'textwidth'
    let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

" Search Case Insensitive Until Uppercase Used:
set ignorecase
set smartcase

" NVIM Create Split To Preview Search And Replace Effects On Lines Out Of Sight:
set inccommand=split

" Delay For Swap File Writes:
set updatetime=100

if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " remove comment leader when joining comments
endif

set formatoptions+=n " smart auto-intending inside numbered lists
set guifont=Source\ Code\ Pro\ Light:h13
set guioptions-=T " don't show toolbar
set hidden " allows you to hide buffers with unsaved changes without being prompted
set laststatus=2 " always show status line
set lazyredraw " don't bother updating screen during macro playback

if has('linebreak')
    set linebreak " wrap long lines at characters in 'breakat'
endif

set list " show whitespace
set listchars=nbsp:⦸
set listchars+=tab:▷┅

set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces " don't autoinsert two spaces after '.', '?', '!' for join command
set noshowmatch " don't jump between matching brackets
set number " show line numbers in gutter

if exists('+relativenumber')
    set relativenumber " show relative numbers in gutter
endif


set scrolloff=3  " start scrolling 3 line before edge of viewport
set shiftround   " always indent by multiple of shiftwidth
set shiftwidth=2 " spaces per tab (when shifting)
set shortmess+=A " ignore annoying swapfile messages
set shortmess+=I " no splash screen
set shortmess+=O " file-read message overites previous
set shortmess+=T " truncate non-file messages in middle
set shortmess+=W " don't echo "[w]"/"[written]" when writing
set shortmess+=a " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o " overwrite file-written messages
set shortmess+=t " truncate file messages at start

if has('linebreak')
  let &showbreak='⤷'
endif

if has('showcmd')
  set showcmd
endif

set sidescrolloff=3 " same as scrolloff, but for columns

set switchbuf=usetab " try to reuse windows/tabs when switching buffers
set tabstop=4 " spaces per tab
set expandtab
set shiftwidth=4
set smarttab " <tab>/<BS> indent/dedent in leading whitespace

if v:progname !=# 'vi'
  set softtabstop=-1 " use 'shiftwidth' for tabs/bs at end of file
endif

if has('windows')
  set splitbelow " open horizontal splits below current window
endif

if has('vertsplit')
  set splitright " open vertical splits to the right of the current window
endif

if has('termguicolors')
  set termguicolors " use guifg/guibg instead of ctermfg/ctermbg in terminal
endif

set textwidth=80

if has('virtualedit')
    set virtualedit=block " allow cursor to move where there is no text in visual block mode
endif

set whichwrap=b,h,l,s,<,>,[,],~ " allow <BS>/h/l/<Left>/<Right>/<Space>, ~ to cross line boundaries
if has('wildignore')
  set wildignore+=*.o,*,*.rej
endif
if has('wildmenu')
    set wildmenu
endif
set wildmode=longest:full,full
