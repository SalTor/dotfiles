local M = {}

local state = {
  win = nil,
  buf = nil,
}

local function close_popup()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
  end

  state.win = nil
  state.buf = nil
end

local function is_popup_open()
  return state.win and vim.api.nvim_win_is_valid(state.win)
end

local function run_systemlist(command)
  local output = vim.fn.systemlist(command)
  for index, line in ipairs(output) do
    output[index] = line:gsub('\r', '')
  end

  if vim.v.shell_error ~= 0 then
    return nil, table.concat(output, '\n')
  end

  return output, nil
end

local function get_current_line_change_id(relative_path, line_number)
  local annotate_cmd = 'jj file annotate ' .. vim.fn.shellescape(relative_path)
  local annotate_lines, err = run_systemlist(annotate_cmd)
  if not annotate_lines then
    return nil, err
  end

  local annotate_line = annotate_lines[line_number]
  if not annotate_line then
    return nil, 'No annotation data for current line'
  end

  local change_id = annotate_line:match '^(%S+)'
  if not change_id then
    return nil, 'Unable to parse jj annotate output'
  end

  return change_id, nil
end

local function get_commit_metadata_lines(change_id)
  local template = table.concat({
    'change_id.shortest(8)',
    '"\\n"',
    'commit_id.shortest(12)',
    '"\\n"',
    'author.name()',
    '"\\n"',
    'author.timestamp().local()',
    '"\\n"',
    'description',
  }, ' ++ ')

  local command = string.format(
    'jj log -r %s --no-graph -T %s',
    vim.fn.shellescape(change_id),
    vim.fn.shellescape(template)
  )
  local output, err = run_systemlist(command)
  if not output then
    return nil, err
  end

  if #output < 4 then
    return nil, 'Unable to parse jj log output'
  end

  local message_lines = vim.list_slice(output, 5)
  if #message_lines == 0 then
    message_lines = { '(no description)' }
  end

  return {
    string.format('Author: %s', output[3]),
    string.format('Date: %s', output[4]),
    string.format('Change: %s', output[1]),
    string.format('Commit: %s', output[2]),
    '',
    'Message:',
    unpack(message_lines),
  }, nil
end

local function open_blame_popup()
  local path = vim.fn.expand '%:p'
  if path == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local relative_path = vim.fn.fnamemodify(path, ':.')
  local change_id, annotate_err = get_current_line_change_id(relative_path, line_number)
  if not change_id then
    vim.notify(annotate_err, vim.log.levels.ERROR)
    return
  end

  local details_lines, metadata_err = get_commit_metadata_lines(change_id)
  if not details_lines then
    vim.notify(metadata_err, vim.log.levels.ERROR)
    return
  end

  close_popup()

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'jjblame'
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, details_lines)
  vim.bo[buf].modifiable = false

  local max_line_width = 0
  for _, line in ipairs(details_lines) do
    max_line_width = math.max(max_line_width, vim.fn.strdisplaywidth(line))
  end

  local width = math.min(math.max(max_line_width + 2, 40), math.floor(vim.o.columns * 0.7))
  local max_height = 16
  local height = math.min(#details_lines, max_height, math.floor(vim.o.lines * 0.6))
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.max(row, 0),
    col = math.max(col, 0),
    style = 'minimal',
    border = 'rounded',
    title = ' jj blame ',
    title_pos = 'center',
  })

  state.win = win
  state.buf = buf

  vim.wo[win].wrap = false
  vim.wo[win].linebreak = false

  vim.keymap.set('n', 'q', close_popup, { buffer = buf, silent = true, nowait = true })
  vim.keymap.set('n', '<Esc>', close_popup, { buffer = buf, silent = true, nowait = true })
end

function M.config()
  vim.api.nvim_create_user_command('JJBlamePopup', function()
    if is_popup_open() then
      close_popup()
      return
    end

    open_blame_popup()
  end, {})
end

return M
