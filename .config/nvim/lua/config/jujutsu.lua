local nmap = require('saltor').nmap

local function open_float(buf, title)
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(0.6 * ui.width)
  local height = math.floor(0.6 * ui.height)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = math.floor((ui.width - width) / 2),
    row = math.floor((ui.height - height) / 2),
    border = 'rounded',
    style = 'minimal',
    noautocmd = true,
    zindex = 50,
    title = title,
  })
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'
  vim.wo[win].cursorline = false
  vim.wo[win].wrap = false
  vim.keymap.set('n', '<Esc>', function()
    pcall(vim.api.nvim_win_close, win, true)
  end, { buffer = buf, nowait = true, silent = true })
  return win
end

local function jj_edit_desc()
  local buf = vim.api.nvim_create_buf(false, true) -- listed=false, scratch=true
  vim.bo[buf].buftype = 'acwrite'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false
  vim.bo[buf].filetype = 'jjdesc'
  vim.api.nvim_buf_set_name(buf, 'JJ:description')
  local win = open_float(buf, 'JJ:description')
  -- vim.cmd("tabnew")
  -- vim.api.nvim_win_set_buf(0, buf)
  local desc = vim.fn.systemlist { 'jj', 'log', '-T', 'description', '--no-graph', '--color=never', '--ignore-working-copy', '-r', '@' }
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, desc)
  vim.api.nvim_create_autocmd('BufWriteCmd', {
    buffer = buf,
    callback = function(args)
      local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
      local text = table.concat(lines, '\n')
      local result = vim.system({ 'jj', 'describe', '--stdin', '--no-edit' }, { stdin = text }):wait()
      if result.code ~= 0 then
        vim.notify('jj describe failed:\n' .. (result.stderr or ''), vim.log.levels.ERROR)
        return
      end
      vim.notify 'JJ description updated ✅'
      vim.cmd 'bd!'
    end,
  })
end

nmap('jd', jj_edit_desc, 'Edit Jujutsu description')
