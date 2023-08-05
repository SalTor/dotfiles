vim.o.cursorline = true
vim.o.relativenumber = true

-- CUSTOMIZATIONS I ADDED
local map = function(mode, keys, cmd, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, keys, cmd, options)
end
local nmap = function(keys, cmd, desc, opts)
  map('n', keys, cmd, desc, opts)
end

nmap('<leader>,', ':Telescope git_files<CR>', 'File finder')
nmap('<leader>/', ':Telescope buffers<CR>', 'Buffers')
nmap('<leader><Space>', ':', 'Command mode', { silent = false })
nmap('<leader>qq', ':qa<CR>', 'Exit')
nmap('<leader><Tab>', '<C-^>', 'Alternate file')

-- f files
nmap('<leader>fs', ':wa<CR>', 'Save all')
nmap('<leader>fj', '<cmd>Explore<CR>', 'Explore')
nmap('<leader>f.s', ':w<CR>', 'Save current file')
nmap('<leader>f.%', ':so %<CR>', 'Source current file')

-- b buffers
nmap('<leader>bd', ':bdelete<CR>', 'Delete buffer')

-- s search
nmap('<leader>sp', ':Telescope live_grep<CR>', 'Search project')
nmap('<leader>sf', ':Telescope current_buffer_fuzzy_find<CR>', 'Search file')

-- g git
nmap('<leader>gs', ':Git<CR>', 'Git Status')
nmap('<leader>gd', ':Git diff<CR>', 'Git Diff')

-- w window
nmap('<leader>w-', ':split<CR><C-w>j', 'Split below')
nmap('<leader>w/', ':vsplit<CR><C-w>l', 'Split right')
nmap('<leader>wh', '<C-w>h', 'Window H')
nmap('<leader>wj', '<C-w>j', 'Window J')
nmap('<leader>wk', '<C-w>k', 'Window K')
nmap('<leader>wl', '<C-w>l', 'Window L')
nmap('<leader>wq', '<C-w>q', 'Close window')

-- g go
nmap('gm', '*', 'Find next occurrence', { silent = false })
nmap('gh', '0', 'Start of line')

-- h help
nmap('<leader>h', ':Telescope help_tags<CR>', 'Help tags')
