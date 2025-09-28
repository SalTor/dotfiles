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
  local line = string.format('%s%s %s', prefix, ts, description)
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

function M.open()
  local file = expand(filepath)
  ensure_parent_dir(file)

  -- check if buffer already exists
  local buf = vim.fn.bufnr(file, false)
  if buf == -1 then
    -- create new buffer and load file
    buf = vim.api.nvim_create_buf(true, false)
    if vim.fn.filereadable(file) == 1 then
      local lines = vim.fn.readfile(file)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
    vim.api.nvim_buf_set_name(buf, file)
    vim.bo[buf].buftype = ''
    vim.bo[buf].bufhidden = 'hide'
    vim.bo[buf].swapfile = true
  end

  -- floating window size & position
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- buffer-local q mapping
  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    -- optional: wipe buffer when closing
    -- if vim.api.nvim_buf_is_valid(buf) then
    --   vim.api.nvim_buf_delete(buf, { force = true })
    -- end
  end, { buffer = buf, nowait = true })
end

function M.setup()
  vim.api.nvim_create_user_command('QuickLog', function()
    M.add_entry()
  end, { desc = 'Prompt for description and append to quicklog file' })

  vim.api.nvim_create_user_command('QuickLogOpen', function()
    M.open()
  end, { desc = 'Open quicklog file in floating window' })
end

nmap('<leader>qn', M.add_entry, 'Take a quick note')
nmap('<leader>qo', M.open, 'Open quicklog in floating window')

return M
