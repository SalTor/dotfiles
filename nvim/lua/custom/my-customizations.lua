vim.o.cursorline = true
vim.o.swapfile = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 3

local sal = require 'saltor'
local nmap, map = sal.nmap, sal.map

-- vv Uncategorized vv
nmap('[ ', 'O<ESC>j', 'Create line above')
nmap('] ', 'o<ESC>k', 'Create line below')
nmap('<leader>qq', ':qa<CR>', 'Exit')
nmap('<leader><Tab>', '<C-^>', 'Alternate file')
-- ^^ Uncategorized ^^

-- b buffers
nmap('<leader>bd', ':bdelete<CR>', 'Delete buffer')

-- d Diagnostic
nmap('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic message')
nmap(']d', vim.diagnostic.goto_next, 'Go to next diagnostic message')

-- e Errors
nmap('<leader>en', function()
  vim.diagnostic.goto_next { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } }
end, 'Next Diagnostic')
nmap('<leader>ep', function()
  vim.diagnostic.goto_prev { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } }
end, 'Prev Diagnostic')
nmap('<leader>el', function()
  local errors = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  vim.diagnostic.setloclist(errors)
end, 'List Diagnostics')

-- f files
nmap('<leader>fs', ':wa<CR>', 'Save all')
nmap('<leader>f.s', ':w<CR>', 'Save current file')
nmap('<leader>f.%', ':so %<CR>', 'Source current file')
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

-- g Go
nmap('gm', '*zz', 'Find next occurrence', { silent = false })
nmap('gh', '0', 'Start of line')
nmap('gl', '$', 'End of line')
map('v', 'gh', '0', 'Start of line')
map('v', 'gl', '$', 'Start of line')

-- h Help
nmap('<leader>hf', ':Telescope help_tags<CR>', 'Help tags')

-- location list
nmap('<C-n>', ':lnext<CR>', 'Next location')
nmap('<C-p>', ':lprev<CR>', 'Prev location')
nmap('<C-l>', ':lopen<CR>', 'Location list')

-- quickfix list
nmap('<leader>cn', ':cnext<CR>', 'Next quickfix')
nmap('<leader>cp', ':cprev<CR>', 'Prev quickfix')
nmap('<leader>cl', ':copen<CR>', 'View quickfix')

-- w window
nmap('<leader>w-', ':split<CR><C-w>j', 'Split below')
nmap('<leader>w/', ':vsplit<CR><C-w>l', 'Split right')
nmap('<leader>wh', '<C-w>h', 'Window H')
nmap('<leader>wj', '<C-w>j', 'Window J')
nmap('<leader>wk', '<C-w>k', 'Window K')
nmap('<leader>wl', '<C-w>l', 'Window L')
nmap('<leader>wq', '<C-w>q', 'Close window')
nmap('<leader>wo', '<C-w>o', 'Maximize window')
nmap('<leader>wr', '<C-w>r', 'Rotate windows')
