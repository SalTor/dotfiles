local sal = require 'saltor'
local map, nmap, vmap = sal.map, sal.nmap, sal.vmap

-- vv Uncategorized vv
nmap('[ ', 'O<ESC>j', 'Create line above')
nmap('] ', 'o<ESC>k', 'Create line below')
nmap('<leader>qq', ':qa<CR>', 'Exit')
nmap('<leader><Tab>', '<C-^>', 'Alternate file')
nmap('<leader>tr', sal.toggle_relativenumber, 'Toggle relativenumber')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
nmap('<leader>ot', ':terminal<CR>', 'Open new terminal')

-- ^^ Uncategorized ^^

-- b buffers
nmap('<leader>bd', ':bprevious|bdelete#<CR>', 'Delete buffer') -- Deletes buffer while maintaining window placement

-- d Diagnostic
nmap('[d', vim.diagnostic.get_prev, 'Go to previous diagnostic message')
nmap(']d', vim.diagnostic.get_next, 'Go to next diagnostic message')

-- e Errors
local severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN }

nmap(']e', function()
  local diagnostic = vim.diagnostic.get_next { severity = severity }
  if diagnostic then
    vim.diagnostic.jump { diagnostic = diagnostic, float = true }
  else
    print 'No diagnostics found.'
  end
end, 'Next Diagnostic')

nmap('[e', function()
  local diagnostic = vim.diagnostic.get_prev { severity = severity }
  if diagnostic then
    vim.diagnostic.jump { diagnostic = diagnostic, float = true }
  else
    print 'No diagnostics found.'
  end
end, 'Prev Diagnostic')

nmap('<leader>el', function()
  local errors = vim.diagnostic.get(0, severity)
  vim.diagnostic.setloclist(errors)
end, 'List Diagnostics')

-- f files
nmap('<leader>fs', ':wa<CR>', 'Save all')
nmap('<leader>f.s', ':w<CR>', 'Save current file')
nmap('<leader>f.%', ':so %<CR>', 'Source current file')

-- g Go
nmap('gm', '*zz', 'Find next occurrence', { silent = false })
nmap('gh', '0', 'Start of line')
nmap('gl', '$', 'End of line')
vmap('gh', '0', 'Start of line')
vmap('gl', '$', 'Start of line')

-- h Help
nmap('<leader>hf', ':Telescope help_tags<CR>', 'Help tags')

-- i info
nmap('[i', function()
  local diagnostic = vim.diagnostic.get_prev { severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT } }
  if diagnostic then
    vim.diagnostic.jump { diagnostic = diagnostic, float = true }
  else
    print 'No diagnostics found.'
  end
end, 'Prev info diagnostic')

nmap(']i', function()
  local diagnostic = vim.diagnostic.get_next { severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT } }
  if diagnostic then
    vim.diagnostic.jump { diagnostic = diagnostic, float = true }
  else
    print 'No diagnostics found.'
  end
end, 'Next info diagnostic')

-- location list
nmap(']l', ':lnext<CR>', 'Next location')
nmap('[l', ':lprev<CR>', 'Prev location')
-- nmap('<C-l>', ':lopen<CR>', 'Location list')

-- quickfix list
nmap(']q', ':cnext<CR>', 'Next quickfix')
nmap('[q', ':cprev<CR>', 'Prev quickfix')
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

-- tabs
nmap('[b', ':tabprevious<cr>', 'Tab left')
nmap(']b', ':tabnext<cr>', 'Tab right')

-- tmux
vim.keymap.set('n', '<leader>O', function()
  require('helpers-tmux').open_or_jump_to_window 'opencode'
end, { desc = 'Open or jump to Opencode in tmux' })

vim.keymap.set('n', '<leader>gg', function()
  require('helpers-tmux').open_or_jump_to_window 'lazygit'
end, { desc = 'Open or jump to Lazygit in tmux' })

vim.keymap.set('n', '<leader>T', function()
  require('helpers-tmux').open_or_jump_to_window('CI=1 pnpm test', {
    window_name = 'pnpm test',
  })
end, { desc = 'Run tests in tmux' })
