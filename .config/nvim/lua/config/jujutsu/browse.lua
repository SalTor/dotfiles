local M = {}

-- Normalize a git remote URL (ssh/scp/https forms) to a plain https base URL.
local function remote_to_https(url)
  url = url:gsub('%.git$', '')
  local host, path = url:match '^git@([^:]+):(.+)$'
  if host then
    return 'https://' .. host .. '/' .. path
  end
  host, path = url:match '^ssh://git@([^/]+)/(.+)$'
  if host then
    return 'https://' .. host .. '/' .. path
  end
  if url:match '^https?://' then
    return (url:gsub('^(https?://)[^@/]*@', '%1'))
  end
  return nil
end

local function browse(line1, line2)
  local path = vim.fn.expand '%:p'
  if path == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  local root = vim.fn.systemlist({ 'jj', 'root' })[1]
  local relative
  if root and path:sub(1, #root + 1) == root .. '/' then
    relative = path:sub(#root + 2)
  else
    relative = vim.fn.fnamemodify(path, ':.')
  end

  local remote_url
  for _, line in ipairs(vim.fn.systemlist { 'jj', 'git', 'remote', 'list' }) do
    local name, url = line:match '^(%S+)%s+(%S+)'
    if name == 'origin' then
      remote_url = url
      break
    end
    remote_url = remote_url or url
  end
  local base = remote_url and remote_to_https(remote_url)
  if not base then
    vim.notify('Could not determine a GitHub remote URL', vim.log.levels.ERROR)
    return
  end

  -- Nearest pushed ancestor, falling back to the working-copy commit.
  local commit = vim.fn.systemlist {
    'jj', 'log', '--no-graph', '--ignore-working-copy',
    '-r', 'latest(::@ & remote_bookmarks())', '-T', 'commit_id',
  }[1]
  if not commit or commit == '' then
    commit = vim.fn.systemlist { 'jj', 'log', '--no-graph', '-r', '@', '-T', 'commit_id' }[1]
  end

  local frag = ''
  if line1 then
    frag = '#L' .. line1
    if line2 and line2 ~= line1 then
      frag = frag .. '-L' .. line2
    end
  end
  local url = base .. '/blob/' .. commit .. '/' .. relative .. frag

  vim.fn.setreg('+', url)
  local opened = pcall(vim.ui.open, url)
  vim.notify((opened and 'Opened (and copied) ' or 'Copied ') .. url)
end

function M.config()
  vim.api.nvim_create_user_command('JJBrowse', function(o)
    if o.range > 0 then
      browse(o.line1, o.line2)
    else
      browse(nil, nil)
    end
  end, { range = true })
end

return M
