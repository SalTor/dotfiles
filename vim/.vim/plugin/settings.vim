highlight CursorLineNR cterm=bold

let g:python_host_prog = '/usr/bin/python'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

set background=dark
set directory^=$HOME/.vim/nvim/tmp//

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
        set fillchars=vert:┃              " BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
        set fillchars+=fold:·             " MIDDLE DOT (U+00B7, UTF-8: C2 B7)
    endif

    if has('nvim-0.3.1')
        set fillchars+=eob:\              " suppress ~ at EndOfBuffer
    endif

    set foldlevelstart=50
    set foldmethod=indent
    set foldtext=wincent#settings#foldtext()
endif

if has('linebreak')
    set breakindent
    if exists('&breakindentopt')
        set breakindentopt=shift:4
    endif
endif

if has('virtualedit')
    set virtualedit=block " allow cursor to move where there is no text in visual block mode
endif

" Search Case Insensitive Until Uppercase Used:
set ignorecase
set smartcase

" Split Prioritization:
set splitbelow
set splitright

" NVIM Create Split To Preview Search And Replace Effects On Lines Out Of Sight:
set inccommand=split

" Tabs Instead Of Spaces:
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " remove comment leader when joining comments
endif

set formatoptions+=n " smart auto-intending inside numbered lists
set guifont=Source\ Code\ Pro\ Light:h13
set laststatus=2 " always show status line
set cursorline

if has('linebreak')
    set linebreak " wrap long lines at characters in 'breakat'
endif

if has('syntax')
    set synmaxcol=200                   " don't bother syntax highlighting long lines
endif

set laststatus=2                      " always show status line
set lazyredraw                        " don't bother updating screen during macro playback

set list " show whitespace
set listchars=nbsp:⦸

set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•
set nojoinspaces " don't autoinsert two spaces after '.', '?', '!' for join command
set noshowmatch " don't jump between matching brackets
set number " show line numbers in gutter
set relativenumber

set scrolloff=3  " start scrolling 3 line before edge of viewport
set shiftround   " always indent by multiple of shiftwidth
set shiftwidth=4 " spaces per tab (when shifting)
set shortmess+=a " use abbreviations in messages eg. `[RO]` instead of `[readonly]`

if !has('nvim')
    " Sync with corresponding nvim :highlight commands in ~/.vim/plugin/autocmds.vim:
    set highlight+=@:Conceal            " ~/@ at end of window, 'showbreak'
    set highlight+=N:DiffText           " make current line number stand out a little
    set highlight+=c:LineNr             " blend vertical separators with line numbers
endif
