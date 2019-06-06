let g:python_host_prog = '/usr/bin/python'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

" Behavior Modification ------------- {{{
    set directory^=$HOME/.vim/nvim/tmp//
    set autoindent                    " maintain indent of current line
    set backspace=indent,start,eol    " allow unrestricted backspacing in insert mode
    set clipboard=unnamed             " Shared Clipboard
    set splitbelow                    " when making a horizontal split, place it on the bottom
    set splitright                    " when making a vertical split, place it on the right

    " Search
        set ignorecase       " search case-insensitively
        set smartcase        " override 'ignorecase' if search pattern contains uppercase
        set inccommand=split " preview search+replace in a separate split (neovim)

    " Tabs instead of spaces
        set expandtab    " use the appropriate number of spaces when hitting <Tab> in insert-mode
        set shiftround   " always indent by multiple of shiftwidth
        set shiftwidth=4 " number of spaces per <Tab> press

    " Line number
        set number          " show line numbers
        set relativenumber  " show relative line number

    set formatoptions+=n " smart auto-intending inside numbered lists
    set guifont=Source\ Code\ Pro\ Light:h13
    set termguicolors  " enable true colors
    set laststatus=2   " always show status line
    set cursorline " Hihglight line that the cursor is on
    set laststatus=2   " always show status line
    set lazyredraw     " don't bother updating screen during macro playback

    " Custom render of certain characters
        set list " show whitespace
        set listchars=nbsp:⦸
        set listchars+=extends:»
        set listchars+=precedes:«
        set listchars+=trail:•

    set nojoinspaces " autoinsert one spaces after '.', '?', '!' for join command <Shift+j>
    set noshowmatch  " don't jump between matching brackets
    set scrolloff=3  " start scrolling 3 line before edge of viewport
    set updatetime=100

    set shortmess+=a " use abbreviations in messages eg. `[RO]` instead of `[readonly]`

    " Some servers have issues with backup files, see #649
    set nobackup
    set nowritebackup

    set hidden

    " always show signcolumns
    set signcolumn=yes

    set mouse=a " enable mouse (selection, resizing windows) -- Already given from terminus package, but including for succinctness

    " Terminal
    if has('nvim')
        " use neovim-remote (pip3 install neovim-remote) allows
        " opening a new split inside neovim instead of nesting
        " neovim processes for git commit
        let $VISUAL      = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
        let $GIT_EDITOR  = 'nvr -cc split --remote-wait +"setlocal bufhidden=delete"'
        let $EDITOR      = 'nvr -l'
        let $ECTO_EDITOR = 'nvr -l'
    endif
" --------- }}}

if !has('nvim')
    " Sync with corresponding nvim :highlight commands in ~/.vim/plugin/autocmds.vim:
    set highlight+=@:Conceal            " ~/@ at end of window, 'showbreak'
    set highlight+=N:DiffText           " make current line number stand out a little
    set highlight+=c:LineNr             " blend vertical separators with line numbers
endif

if v:version > 703 || v:version == 703 && has('patch541')
    set formatoptions+=j " remove comment leader when joining comments
endif

if has('linebreak')
    set linebreak " wrap long lines at characters in 'breakat'
endif

if has('syntax')
    set synmaxcol=400                   " don't bother syntax highlighting long lines
endif

if exists('&belloff')
    set belloff=all
endif

" Folding
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
