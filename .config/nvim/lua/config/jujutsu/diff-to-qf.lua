vim.api.nvim_create_user_command('JJDiffQuickfix', function()
  -- Run jj diff --summary and capture output
  local output = vim.fn.systemlist 'jj diff --summary'

  local files = {}
  for _, line in ipairs(output) do
    -- Skip lines starting with "D "
    if not line:match '^D ' and not line:match '^R ' then
      local path = line:match '%S+%s+(.*)'
      if path then
        table.insert(files, { filename = path })
      end
    end
  end

  if #files == 0 then
    vim.notify('No modified files found', vim.log.levels.INFO)
    return
  end

  -- Populate the quickfix list
  vim.fn.setqflist({}, 'r', { title = 'jj diff --summary', items = files })
  vim.cmd 'copen'
end, {})
