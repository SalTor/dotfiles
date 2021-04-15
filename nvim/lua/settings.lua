local g = vim.g
local o = vim.o
local cmd = vim.cmd

g.python_host_prog = '/usr/bin/python'
g.python3_host_prog = '/usr/bin/python3'
g.ruby_host_prog = 'rvm system do neovim-ruby-host'

cmd('syntax on')
cmd('filetype indent plugin on')

cmd('language en_US.utf-8')

o.backup = false
o.writebackup = false
o.swapfile = false

o.undofile = true

o.errorbells = false
o.visualbell = false
o.belloff = 'all'

o.showmatch = false
o.showmode = false
o.showcmd = false
o.wildmenu = true
o.lazyredraw = true
o.ruler = false

o.number = true
o.cursorline = false
o.whichwrap = ''
o.backspace = 'start,eol,indent'

o.expandtab = true
o.smarttab = false
o.shiftwidth = 4
o.tabstop = 4
o.list = true

o.scrolloff = 3

o.listchars = 'tab:>-,nbsp:⦸,extends:»,precedes:«,trail:•'

o.wrap = true
o.breakindent = true
o.breakindentopt = 'shift:2'
o.showbreak = '⤷ '

o.autoindent = true
o.smartindent = true

-- o.foldtext = 'saltor#settings#foldtext()'
o.foldlevelstart = 50
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
cmd('set foldopen-=block')

o.virtualedit = 'block'

o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true

o.inccommand = 'split'

o.splitbelow = true
o.splitright = true

o.hidden = true
o.switchbuf = 'usetab'

o.timeoutlen = 500
o.updatetime = 300

o.shortmess = 'AIOTWotcla'

o.formatoptions = 'nj'
o.joinspaces = false

o.completeopt = 'menu'
