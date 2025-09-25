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

function M.vmap(keys, cmd, desc, opts)
  M.map('v', keys, cmd, desc, opts)
end

function M.bnmap(keys, cmd, desc, opts)
  local options = { buffer = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  M.map('n', keys, cmd, desc, options)
end

local function getVisualSelection()
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

function M.searchProject()
  local text = getVisualSelection()
  require('telescope.builtin').live_grep { default_text = text }
end

function M.is_inside_git_repo()
  local handle = io.popen 'git rev-parse --is-inside-work-tree 2>/dev/null'
  if handle then
    local result = handle:read '*a'
    handle:close()
    return result:match 'true' ~= nil
  end
  return false
end

function M.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then
        k = '"' .. k .. '"'
      end
      s = s .. '[' .. k .. '] = ' .. M.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

local session_relativenumber = vim.o.relativenumber

function M.toggle_relativenumber()
  session_relativenumber = not session_relativenumber

  vim.o.relativenumber = session_relativenumber

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.wo[win].number then -- only if absolute numbers are on
      vim.wo[win].relativenumber = session_relativenumber
    end
  end
end

return M
