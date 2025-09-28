local M = {}

local nmap = require('saltor').nmap

local filepath = '~/notes/quicklog.md'
local prefix = '- '
local time_format = '%Y-%m-%d %H:%M'

local function ensure_parent_dir(path)
  local dir = vim.fn.fnamemodify(path, ':h')
  if dir ~= '' and vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

local function expand(path)
  return vim.fn.expand(path)
end

local function build_line(description)
  local ts = os.date(time_format)
  local line = string.format('%s%s %s\n', prefix, ts, description)
  return line
end

local function append_line(path, line)
  ensure_parent_dir(path)
  vim.fn.writefile({ line }, path, 'a')
end

function M.add_entry()
  local file = expand(filepath)
  vim.ui.input({ prompt = 'Description: ' }, function(description)
    if not description or description == '' then
      vim.notify('QuickLog: empty description, aborted.', vim.log.levels.WARN)
      return
    end
    local line = build_line(description)
    append_line(file, line)
    vim.notify('QuickLog: appended to ' .. file, vim.log.levels.INFO)
  end)
end

function M.setup()
  vim.api.nvim_create_user_command('QuickLog', function()
    M.add_entry()
  end, { desc = 'Prompt for description and append to quicklog file' })
end

nmap('<leader>qn', M.add_entry, 'Take a quick note')

return M
