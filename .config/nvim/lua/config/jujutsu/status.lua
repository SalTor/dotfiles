local M = {}

local nmap = require('saltor').nmap

local function edit_description(refresh_callback)
  -- Get current description
  local handle = io.popen 'jj log -r @ --no-graph -T description'
  if not handle then
    vim.notify('Failed to get current description', vim.log.levels.ERROR)
    return
  end
  local current_desc = handle:read('*a'):gsub('\n$', '') -- Remove trailing newline
  handle:close()

  -- Create or switch to edit buffer
  local buf_name = 'JJ_DESCRIBE_EDITMSG'
  local existing_buf = vim.fn.bufnr(buf_name)
  local buf = existing_buf ~= -1 and existing_buf or vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_name(buf, buf_name)

  -- Set buffer options
  vim.bo[buf].buftype = 'acwrite'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'jjdescription'

  -- Set initial content
  local lines = vim.split(current_desc, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set up autocmd to save description on write
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = function()
      local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local new_desc = table.concat(content, '\n')

      -- Save description
      local cmd = string.format('jj describe -m %s', vim.fn.shellescape(new_desc))
      local save_handle = io.popen(cmd)
      if save_handle then
        save_handle:close()
        vim.notify('Description updated', vim.log.levels.INFO)
        vim.bo[buf].modified = false
        vim.api.nvim_buf_delete(buf, { force = true }) -- Delete the buffer
        if refresh_callback then
          refresh_callback()
        end
      else
        vim.notify('Failed to update description', vim.log.levels.ERROR)
      end
    end,
  })

  -- Set up autocmd to refresh on buffer close without saving
  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = buf,
    callback = function()
      if refresh_callback then
        refresh_callback()
      end
    end,
  })

  -- Open in vertical split above current window
  vim.cmd 'above split'
  vim.api.nvim_win_set_buf(0, buf)
end

local function edit_commit_message(refresh_callback)
  -- Create or switch to commit buffer
  local buf_name = 'JJ_COMMIT_EDITMSG'
  local existing_buf = vim.fn.bufnr(buf_name)
  local buf = existing_buf ~= -1 and existing_buf or vim.api.nvim_create_buf(false, true)

  vim.api.nvim_buf_set_name(buf, buf_name)

  -- Set buffer options
  vim.bo[buf].buftype = 'acwrite'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'jjdescription'

  -- Set up autocmd to commit on write
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = function()
      local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local commit_msg = table.concat(content, '\n')

      -- Commit with message
      local cmd = string.format('jj commit -m %s', vim.fn.shellescape(commit_msg))
      local commit_handle = io.popen(cmd)
      if commit_handle then
        commit_handle:close()
        vim.notify('Committed successfully', vim.log.levels.INFO)
        vim.bo[buf].modified = false
        vim.api.nvim_buf_delete(buf, { force = true }) -- Delete the buffer
        if refresh_callback then
          refresh_callback()
        end
      else
        vim.notify('Failed to commit', vim.log.levels.ERROR)
      end
    end,
  })

  -- Set up autocmd to refresh on buffer close without saving
  vim.api.nvim_create_autocmd('BufWipeout', {
    buffer = buf,
    callback = function()
      if refresh_callback then
        refresh_callback()
      end
    end,
  })

  -- Open in vertical split above current window
  vim.cmd 'above split'
  vim.api.nvim_win_set_buf(0, buf)
end

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

  local function refresh_status()
    -- Re-run jj status and update buffer
    local refresh_handle = io.popen 'jj status'
    if not refresh_handle then
      return
    end
    local refresh_result = refresh_handle:read '*a'
    refresh_handle:close()

    -- Parse and update buffer content
    local lines = {}
    local file_lines = {}
    for i, line in ipairs(vim.split(refresh_result, '\n')) do
      table.insert(lines, line)
      local kind, path = line:match '^([AMD])%s+(.+)$'
      if kind == 'A' or kind == 'M' then
        file_lines[i - 1] = path
      end
    end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    -- Update file_lines mapping for the buffer
    vim.b[buf].file_lines = file_lines
  end

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

  -- Store file_lines mapping in buffer variable
  vim.b[buf].file_lines = file_lines

  -- Set keymap to open file on <CR>
  vim.api.nvim_buf_set_keymap(buf, 'n', '<CR>', '', {
    noremap = true,
    silent = true,
    callback = function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line_nr = cursor[1] - 1
      local current_file_lines = vim.b[buf].file_lines or {}
      local file = current_file_lines[line_nr]
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

  -- Set d to edit description (override vim's d operator for this buffer)
  vim.keymap.set({ 'n', 'v', 'o' }, 'd', function()
    edit_description(refresh_status)
  end, {
    buffer = buf,
    silent = true,
    nowait = true,
  })

  -- Set c to commit (override vim's c operator for this buffer)
  vim.keymap.set({ 'n', 'v', 'o' }, 'c', function()
    edit_commit_message(refresh_status)
  end, {
    buffer = buf,
    silent = true,
    nowait = true,
  })

  -- Open status in a small vertical split above
  vim.cmd 'above split'
  vim.cmd 'resize 15'
  vim.api.nvim_win_set_buf(0, buf)
end

function M.config()
  vim.api.nvim_create_user_command('JJStatus', open_jj_status, {})

  nmap('<leader>gs', '<cmd>JJStatus<cr>', 'View current Jujutsu status')
end

return M
