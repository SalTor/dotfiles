local M = {}

local ns = vim.api.nvim_create_namespace 'jjblame'
local state = { win = nil, buf = nil, src_win = nil }

local function run_systemlist(args)
  local output = vim.fn.systemlist(args)
  if vim.v.shell_error ~= 0 then
    return nil, table.concat(output, '\n')
  end
  return output, nil
end

-- Pad/truncate s to exactly w display columns (truncation adds an ellipsis).
local function pad(s, w)
  if vim.fn.strdisplaywidth(s) > w then
    while vim.fn.strdisplaywidth(s) > w - 1 do
      s = vim.fn.strcharpart(s, 0, vim.fn.strchars(s) - 1)
    end
    s = s .. '…'
  end
  return s .. string.rep(' ', math.max(0, w - vim.fn.strdisplaywidth(s)))
end

local function clear_src()
  if state.src_win and vim.api.nvim_win_is_valid(state.src_win) then
    vim.wo[state.src_win].scrollbind = false
    vim.wo[state.src_win].cursorbind = false
  end
  state.win, state.buf, state.src_win = nil, nil, nil
end

local function close()
  local win = state.win
  clear_src()
  if win and vim.api.nvim_win_is_valid(win) then
    pcall(vim.api.nvim_win_close, win, true)
  end
end

-- Floating window showing `jj show --git` for the change under the cursor.
local function show_commit(change_ids)
  return function()
    local lnum = vim.api.nvim_win_get_cursor(0)[1]
    local cid = change_ids[lnum]
    if not cid or cid == '' then
      return
    end

    local out, err = run_systemlist { 'jj', 'show', '--git', '--color=never', '-r', cid }
    if not out then
      vim.notify('jj show failed:\n' .. err, vim.log.levels.ERROR)
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'wipe'
    vim.bo[buf].swapfile = false
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
    vim.bo[buf].modifiable = false
    vim.bo[buf].filetype = 'diff'

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      col = math.floor((vim.o.columns - width) / 2),
      row = math.floor((vim.o.lines - height) / 2),
      border = 'rounded',
      style = 'minimal',
      title = ' ' .. cid .. ' ',
      title_pos = 'center',
    })
    vim.wo[win].wrap = false
    for _, key in ipairs { 'q', '<Esc>' } do
      vim.keymap.set('n', key, function()
        pcall(vim.api.nvim_win_close, win, true)
      end, { buffer = buf, nowait = true, silent = true })
    end
  end
end

local function open_gutter()
  local path = vim.fn.expand '%:p'
  if path == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end
  local relative = vim.fn.fnamemodify(path, ':.')
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]

  local template = table.concat({
    'commit.change_id().shortest(8)',
    [["\t"]],
    'commit.author().name()',
    [["\t"]],
    'commit.author().timestamp().local().format("%Y-%m-%d")',
    [["\n"]],
  }, ' ++ ')

  local out, err = run_systemlist { 'jj', 'file', 'annotate', '-T', template, relative }
  if not out then
    vim.notify('jj file annotate failed:\n' .. err, vim.log.levels.ERROR)
    return
  end
  local n = #out
  if n == 0 then
    vim.notify('`jj file annotate` produced no output', vim.log.levels.ERROR)
    return
  end

  local id_w, author_w = 8, 14
  local display, change_ids, marks = {}, {}, {}
  for i, line in ipairs(out) do
    local id, author, date = line:match '^(.-)\t(.-)\t(.*)$'
    local id_col = pad(id or '', id_w)
    local author_col = pad(author or '', author_w)
    local text = id_col .. ' ' .. author_col .. ' ' .. (date or '')
    display[i] = text
    change_ids[i] = vim.trim(id or '')
    local author_start = #id_col + 1
    local date_start = author_start + #author_col + 1
    marks[i] = {
      { 0, #id_col, 'JjBlameId' },
      { author_start, author_start + #author_col, 'JjBlameAuthor' },
      { date_start, #text, 'JjBlameDate' },
    }
  end

  local src_win = vim.api.nvim_get_current_win()
  local view = vim.fn.winsaveview()
  vim.cmd 'leftabove vsplit'
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, display)
  vim.bo[buf].buftype = 'nofile'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'jjblame'
  vim.bo[buf].modifiable = false

  for i, line_marks in ipairs(marks) do
    for _, m in ipairs(line_marks) do
      pcall(vim.api.nvim_buf_set_extmark, buf, ns, i - 1, m[1], { end_col = m[2], hl_group = m[3] })
    end
  end

  local width = 0
  for _, l in ipairs(display) do
    width = math.max(width, vim.fn.strdisplaywidth(l))
  end
  vim.api.nvim_win_set_width(win, math.min(width + 1, math.floor(vim.o.columns * 0.5)))

  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'
  vim.wo[win].foldcolumn = '0'
  vim.wo[win].wrap = false
  vim.wo[win].winfixwidth = true
  vim.wo[win].cursorline = true

  vim.fn.winrestview { topline = view.topline, lnum = math.min(cur_line, n), col = 0, leftcol = 0 }
  -- scrollbind only: the windows scroll together but cursors move independently.
  -- Note: <CR> shows the commit for the gutter's cursor line, which may differ
  -- from where the source cursor sits.
  vim.wo[win].scrollbind = true
  vim.wo[src_win].scrollbind = true

  state.win, state.buf, state.src_win = win, buf, src_win

  for _, key in ipairs { 'q', 'gq', '<Esc>' } do
    vim.keymap.set('n', key, close, { buffer = buf, silent = true, nowait = true })
  end
  vim.keymap.set('n', '<CR>', show_commit(change_ids), { buffer = buf, silent = true, nowait = true, desc = 'jj show this change' })

  vim.api.nvim_create_autocmd('WinClosed', {
    pattern = tostring(win),
    once = true,
    callback = clear_src,
  })
end

function M.config()
  vim.api.nvim_set_hl(0, 'JjBlameId', { link = 'Identifier', default = true })
  vim.api.nvim_set_hl(0, 'JjBlameAuthor', { link = 'Function', default = true })
  vim.api.nvim_set_hl(0, 'JjBlameDate', { link = 'Comment', default = true })

  vim.api.nvim_create_user_command('JJBlame', function()
    if vim.bo.filetype == 'jjblame' or (state.win and vim.api.nvim_win_is_valid(state.win)) then
      close()
      return
    end
    open_gutter()
  end, {})
end

return M
