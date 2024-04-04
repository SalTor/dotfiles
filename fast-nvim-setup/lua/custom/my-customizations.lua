vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.scrolloff = 3

require 'saltor'
local nmap = SalTor_map_normal
local map = SalTor_map

local utils = require 'telescope.utils'
local myfunc = function()
  local git_root = utils.get_os_command_output { 'git', 'rev-parse', '--show-toplevel', '%:p:h' }
  print(git_root)
  if git_root == '0' then
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
nmap('<leader>f.s', ':w<CR>', 'Save current file')
nmap('<leader>f.%', ':so %<CR>', 'Source current file')
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

-- b buffers
nmap('<leader>bd', ':bdelete<CR>', 'Delete buffer')

-- s search
function Sal_SearchProject()
  local text = vim.getVisualSelection()
  require('telescope.builtin').live_grep { default_text = text }
end
function vim.getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end
nmap('<leader>sp', ':Telescope live_grep<CR>', 'Search project')
nmap('<leader>sf', ':Telescope current_buffer_fuzzy_find<CR>', 'Search file')
map('v', '<leader>sp', Sal_SearchProject, 'Search project (selection)')

-- g go
nmap('gm', '*zz', 'Find next occurrence', { silent = false })
nmap('gh', '0', 'Start of line')
nmap('gl', '$', 'End of line')
map('v', 'gh', '0', 'Start of line')
map('v', 'gl', '$', 'Start of line')

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
-- nmap('n', 'nzz', 'Next occurrence (centered)')
