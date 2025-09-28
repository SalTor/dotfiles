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

local function jj_log()
  -- Toggle: if a jjlog terminal is visible, close it
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local b = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buftype == 'terminal' and vim.bo[b].filetype == 'jjlog' then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  -- Remember current window, open a vsplit, and make it current
  local prev_win = vim.api.nvim_get_current_win()
  vim.cmd 'vsplit'
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(win, math.max(20, math.floor(vim.o.columns * 0.30)))
  vim.wo[win].winfixwidth = true

  -- Ensure the split has a fresh, unnamed buffer and set simple opts
  vim.cmd 'enew'
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].filetype = 'jjlog'
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].swapfile = false

  -- START the terminal job IN THIS WINDOW
  -- Use env.PAGER so jj uses less; no shell needed
  local jid = vim.fn.jobstart(
    { 'jj', 'log', '-r', '"stack()"' }, -- adjust revset as you like
    {
      term = true, -- ← attach a real terminal to *current* window
      env = { PAGER = 'less -R' },
      on_exit = function(_, _)
        if vim.api.nvim_win_is_valid(win) then
          vim.schedule(function()
            pcall(vim.api.nvim_win_close, win, true)
          end)
        end
      end,
    }
  )

  if jid <= 0 then
    vim.notify('Failed to start `jj log` terminal', vim.log.levels.ERROR)
    -- go back to previous window if something failed
    if vim.api.nvim_win_is_valid(prev_win) then
      vim.api.nvim_set_current_win(prev_win)
    end
    return
  else
    vim.notify 'Successfully started `jj log` terminal'
  end

  -- drop into terminal-mode so less receives keys
  vim.cmd 'startinsert'
  -- vim.cmd 'startinsert'
end

function Jdiff(revision)
  if not revision or revision == '' then
    revision = '@-'
  end
  local change_id = vim.fn.system(string.format("jj show --no-patch -T 'change_id.shortest()' %s", vim.fn.shellescape(revision)))
  -- Save the current buffer's filename
  local filename = vim.api.nvim_buf_get_name(0)
  -- Create a new vertical split with a scratch buffer
  vim.cmd 'vert new'
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'wipe'
  vim.opt_local.swapfile = false
  vim.api.nvim_buf_set_name(0, string.format('%s:%s(%s)', filename, revision, change_id))
  -- Execute the command and insert its output into the buffer
  local cmd = string.format('jj file show -r %s %s', vim.fn.shellescape(revision), vim.fn.shellescape(filename))
  local output = vim.fn.system(cmd)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
  -- Make the new buffer read-only
  vim.cmd 'setlocal readonly'
  -- Enable diff mode for both buffers
  vim.cmd 'diffthis'
  vim.cmd 'wincmd p'
  vim.cmd 'diffthis'
  vim.cmd 'wincmd p'

  local scratch_buf = vim.api.nvim_get_current_buf()

  vim.keymap.set('n', 'q', function()
    vim.cmd 'diffoff' -- turn off diff mode for both windows
    vim.cmd 'close' -- then close this scratch buffer
  end, { buffer = scratch_buf, silent = true })
end
vim.api.nvim_create_user_command('Jdiff', function(opts)
  Jdiff(opts.args)
end, { nargs = '?' })

nmap('<leader>jd', jj_edit_desc, 'Edit Jujutsu description')
nmap('<leader>jl', jj_log, 'Jujutsu log')
nmap('<leader>gs', Jdiff, 'Jujutsu Diff')
