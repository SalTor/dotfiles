" Syntax highlighting, and automatic, language-dependent indentation
syntax on
filetype indent plugin on

" Line number
set number
set relativenumber

" Highlight line that the cursor is on
set cursorline

" Suppress ~ at EndOfBuffer
set fillchars+=eob:\ 

set timeoutlen=500

" Interface abbreviations
"  f: use "(3 of 5)" instead of "(file 3 of 5)"
"  i: use "[noeol]"  instead of "[Incomplete last line]"
"  l: use "999L, 888C" instead of "999 lines, 888 characters"
"  m: use "[+]"   instead of "[Modified]"
"  n: use "[New]" instead of "[New File]"
"  r: use "[RO]"  instead of "[readonly]"
"  w: use "[w]"   instead of "written" for file write message
"     and "[a]"   instead of "appended" for ':w >> file' command
"  x: use "[dos]" instead of "[dos format]", "[unix]" instead of
"         "[unix format]" and "[mac]" instead of "[mac format]".
"  a: use all of the above
"  c: don't pass messages to |ins-completion-menu'
"  !!!! Startify includes 'I' which hides the intro message default in vim
"  !!!! Deoplete includes 'c' which hides the default 'match 1 of 2' et al
"  !!!! ALE      includes 'T' which truncates messages if they don't fit in the command section
set shortmess+=a
set shortmess+=c

" n: Smart auto-intending inside numbered lists
" o: Making a comment after oO
" j: Remove comment leader when joining comments
set formatoptions+=n
set formatoptions-=o
set formatoptions+=j

" Don't bother syntax highlighting long lines
set synmaxcol=400

" Only redraw when necessary
set lazyredraw

" Hide current mode 'INSERT' in command section. I use statusline for displaying this
set noshowmode

" Place for swap files
set directory^=$HOME/.vim/nvim/tmp//

" Allow unrestricted backspacing in insert mode
set backspace=indent,start,eol

" Shared Clipboard
set clipboard=unnamed

set spelllang=en_us

" Hide buffers that aren't in a window
set hidden

" Handle splits. Below when new sp, right when new vsp
set splitbelow
set splitright

" Search
set ignorecase
set smartcase
set inccommand=split " (neovim) preview search+replace in a separate split

" Tabs instead of spaces
set shiftwidth=4
set expandtab
set shiftround

" Show whitespace, and customize render of certain characters
set list
set listchars=nbsp:⦸
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=trail:•

" Autoinsert one spaces after '.', '?', '!' for join command <Shift+j>
set nojoinspaces

" Don't jump between matching brackets, and start scrolling 3 line before edge of viewport
set noshowmatch
set scrolloff=3
set updatetime=100

" Wrap long lines at characters in 'breakat' and when lines wrap, they're indented
set linebreak
set breakindent
set breakindentopt=shift:4

" Folding
set foldmethod=indent
set foldtext=saltor#settings#foldtext()
set foldlevelstart=50

" Allow cursor to move where there is no text in visual block mode
set virtualedit=block

let g:python_host_prog = '/usr/bin/python'
let g:pymode_python='python3'
let g:python3_host_prog = '/usr/local/bin/python3.8'
let g:ruby_host_prog   = 'rvm system do neovim-ruby-host'

let g:js_filetypes=[
\   'javascript',
\   'javascript.jsx',
\   'javascript.jest',
\   'javascript.jest.jsx'
\ ]
