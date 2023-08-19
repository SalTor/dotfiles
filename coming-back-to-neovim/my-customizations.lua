vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.swapfile = false

-- CUSTOMIZATIONS I ADDED
local map = function(mode, keys, cmd, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, keys, cmd, options)
  -- vim.api.nvim_set_keymap(mode, keys, cmd, options)
end
local nmap = function(keys, cmd, desc, opts)
  map('n', keys, cmd, desc, opts)
end

local utils = require "telescope.utils"
local myfunc = function()
  local git_root = utils.get_os_command_output({ "git", "rev-parse", "--show-toplevel", "%:p:h" })
  print(git_root)
  if git_root == "0" then
    -- print("we are in a git repo")
  else
    -- print("not in a git repo")
  end
end

nmap('<leader>,', ':Telescope git_files<CR>', 'File finder')
nmap('<leader>/', ':Telescope buffers<CR>', 'Buffers')
-- nmap('<leader><Space>', myfunc, 'Command mode', { silent = false })
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

-- g go
nmap('gm', '*', 'Find next occurrence', { silent = false })
nmap('gh', '0', 'Start of line')
nmap('gl', '$', 'End of line')

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
nmap('<leader>wo', '<C-w>o', 'Maximize window')

-- h help
nmap('<leader>hf', ':Telescope help_tags<CR>', 'Help tags')

-- e errors
nmap('<leader>en', ':lua vim.diagnostic.goto_next()<CR>', 'Next Diagnostic')
-- nmap('<leader>en', my_goto_next_with::vim.diagnostic.open_float(), 'Next Diagnostic')
nmap('<leader>ep', ':lua vim.diagnostic.goto_prev()<CR>', 'Prev Diagnostic')
-- nmap('<leader>ep', my_goto_prev_with::vim.diagnostic.open_float(), 'Prev Diagnostic')
nmap('<leader>el', ':lua vim.diagnostic.setloclist(vim.diagnostic.get())<CR>', 'List Diagnostics')

-- location list
nmap('<C-n>', ':lnext<CR>', 'Next location')
nmap('<C-p>', ':lprev<CR>', 'Prev location')
nmap('<C-l>', ':lopen<CR>', 'Location list')

-- quickfix list
nmap('<leader>cn', ':cnext<CR>', 'Next quickfix')
nmap('<leader>cp', ':cprev<CR>', 'Prev quickfix')
nmap('<leader>cl', ':copen<CR>', 'View quickfix')

-- misc

nmap('[ ', 'O<ESC>j', 'Create line above')
nmap('] ', 'o<ESC>k', 'Create line below')


-- HARPOON
nmap('<leader>ha', ':lua require("harpoon.mark").add_file()<CR>')
nmap('`l', ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
nmap('`a', ':lua require("harpoon.ui").nav_file(1)<CR>')
nmap('`1', ':lua require("harpoon.ui").nav_file(1)<CR>')
nmap('`r', ':lua require("harpoon.ui").nav_file(2)<CR>')
nmap('`2', ':lua require("harpoon.ui").nav_file(2)<CR>')
nmap('`s', ':lua require("harpoon.ui").nav_file(3)<CR>')
nmap('`3', ':lua require("harpoon.ui").nav_file(3)<CR>')
nmap('`t', ':lua require("harpoon.ui").nav_file(4)<CR>')
nmap('`4', ':lua require("harpoon.ui").nav_file(4)<CR>')
