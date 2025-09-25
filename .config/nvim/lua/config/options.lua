local global = vim.g

global.python3_host_prog = '/opt/homebrew/bin/python3'

local opt = vim.o -- to set options

opt.winborder = 'rounded'
opt.hlsearch = false -- Set highlight on search
opt.number = true -- Make line numbers default
opt.relativenumber = true

-- Enable mouse mode
opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 600

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

opt.termguicolors = true

opt.cursorline = true
opt.swapfile = false
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.scrolloff = 3
