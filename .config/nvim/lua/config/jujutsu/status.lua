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

  -- Create floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
    title = ' Edit Description ',
    title_pos = 'center',
  })

  -- Set buffer options
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'markdown'

  -- Set initial content
  local lines = vim.split(current_desc, '\n')
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Set keymaps
  local function save_and_close()
    local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local new_desc = table.concat(content, '\n')

    -- Save description
    local cmd = string.format('jj describe -m %s', vim.fn.shellescape(new_desc))
    local save_handle = io.popen(cmd)
    if save_handle then
      save_handle:close()
      vim.notify('Description updated', vim.log.levels.INFO)
    else
      vim.notify('Failed to update description', vim.log.levels.ERROR)
    end

    vim.api.nvim_win_close(win, true)
    if refresh_callback then
      refresh_callback()
    end
  end

  local function close_without_save()
    vim.api.nvim_win_close(win, true)
    if refresh_callback then
      refresh_callback()
    end
  end

  -- Save with Ctrl+S or :w
  vim.keymap.set('n', '<leader>fs', save_and_close, { buffer = buf, silent = true })
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = save_and_close,
  })

  -- Close with Escape or q
  vim.keymap.set('n', '<Esc>', close_without_save, { buffer = buf, silent = true })
  vim.keymap.set('n', 'q', close_without_save, { buffer = buf, silent = true })
end

local function edit_commit_message(refresh_callback)
  -- Create floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.6)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'rounded',
    title = ' Commit Message ',
    title_pos = 'center',
  })

  -- Set buffer options
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'markdown'

  -- Set keymaps
  local function commit_and_close()
    local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local commit_msg = table.concat(content, '\n')

    -- Commit with message
    local cmd = string.format('jj commit -m %s', vim.fn.shellescape(commit_msg))
    local commit_handle = io.popen(cmd)
    if commit_handle then
      commit_handle:close()
      vim.notify('Committed successfully', vim.log.levels.INFO)
    else
      vim.notify('Failed to commit', vim.log.levels.ERROR)
    end

    vim.api.nvim_win_close(win, true)
    if refresh_callback then
      refresh_callback()
    end
  end

  local function close_without_commit()
    vim.api.nvim_win_close(win, true)
    if refresh_callback then
      refresh_callback()
    end
  end

  -- Save with Ctrl+S or :w
  vim.keymap.set('n', '<leader>fs', commit_and_close, { buffer = buf, silent = true })
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = commit_and_close,
  })

  -- Close with Escape or q
  vim.keymap.set('n', '<Esc>', close_without_commit, { buffer = buf, silent = true })
  vim.keymap.set('n', 'q', close_without_commit, { buffer = buf, silent = true })
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

  -- Create/reuse window
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(current_win, buf)
end

function M.config()
  vim.api.nvim_create_user_command('JJStatus', open_jj_status, {})

  nmap('<leader>gs', '<cmd>JJStatus<cr>', 'View current Jujutsu status')
end

return M
