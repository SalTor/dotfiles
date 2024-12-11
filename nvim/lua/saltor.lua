local M = {}

function M.map(mode, keys, cmd, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, keys, cmd, options)
end

function M.nmap(keys, cmd, desc, opts)
  M.map('n', keys, cmd, desc, opts)
end

function M.bnmap(keys, cmd, desc, opts)
  local options = { buffer = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  M.map('n', keys, cmd, desc, options)
end

function M.searchProject()
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

return M
