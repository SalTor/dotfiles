local M = {}

local nmap = require('saltor').nmap

local function open_jj_status()
  -- Run jj status
  local handle = io.popen 'jj status'
  if not handle then
    return
  end
  local result = handle:read '*a'
  handle:close()

  -- Create or reuse buffer
  local buf_name = '__JJ_STATUS__'
  local existing_buf = vim.fn.bufnr(buf_name)
  local buf = existing_buf ~= -1 and existing_buf or vim.api.nvim_create_buf(false, true)

  -- Set contents
  local lines = {}
  local file_lines = {} -- line number -> filename for added/modified
  for i, line in ipairs(vim.split(result, '\n')) do
    table.insert(lines, line)
    local kind, path = line:match '^([AMD])%s+(.+)$'
    if kind == 'A' or kind == 'M' then
      file_lines[i - 1] = path -- store line index (0-based)
    end
  end
  vim.api.nvim_buf_set_name(buf, buf_name)

  -- Buffer settings
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'hide'
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = true
  vim.bo[buf].filetype = 'jjstatus'

  -- Set contents
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  -- Set keymap to open file on <CR>
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
    noremap = true,
    silent = true,
    callback = function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line_nr = cursor[1] - 1
      local file = file_lines[line_nr]
      if file then
        vim.cmd('edit ' .. vim.fn.fnameescape(file))
      end
    end,
  })

  -- Set q to close
  vim.api.nvim_buf_set_keymap(buf, 'n', 'q', '', {
    noremap = true,
    silent = true,
    callback = function()
      vim.api.nvim_buf_delete(buf, { force = true })
    end,
  })

  -- Create/reuse window
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(current_win, buf)
end

function M.config()
  vim.api.nvim_create_user_command('JJStatus', open_jj_status, {})

  nmap('<leader>gs', '<cmd>JJStatus<cr>', 'View current Jujutsu status')
end

return M
