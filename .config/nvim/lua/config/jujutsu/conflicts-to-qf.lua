local M = {}

local function load_jj_conflicts_to_qf()
  -- Run jj status to get conflicted files
  local handle = io.popen "jj status | grep '2-sided conflict' | awk '{print $1}'"
  if not handle then
    return
  end
  local result = handle:read '*a'
  handle:close()

  -- Table to store quickfix items
  local qf_list = {}

  -- Process each conflicted file
  for file in result:gmatch '[^\r\n]+' do
    local conflict_file = io.open(file, 'r')
    if conflict_file then
      local line_num = 0
      local in_conflict = false
      local conflict_text = {}

      for line in conflict_file:lines() do
        line_num = line_num + 1

        if line:match '^<<<<<<<' then
          in_conflict = true
          conflict_text = { line } -- Start a new conflict block
        elseif line:match '^>>>>>>>' and in_conflict then
          table.insert(conflict_text, line)
          local text = table.concat(conflict_text, ' | ') -- Concatenate for quickfix display

          -- Add to quickfix list
          table.insert(qf_list, {
            filename = file,
            lnum = line_num - #conflict_text + 1, -- Start line of the conflict
            col = 1,
            text = text,
          })

          in_conflict = false
        elseif in_conflict then
          table.insert(conflict_text, line)
        end
      end
      conflict_file:close()
    end
  end

  -- Load conflicts into the quickfix list
  if #qf_list > 0 then
    vim.fn.setqflist(qf_list, 'r') -- Replace quickfix list
    vim.cmd 'copen' -- Open quickfix window
  else
    print 'No Jujutsu conflicts found!'
  end
end

function M.config()
  vim.api.nvim_create_user_command('JJConflicts', load_jj_conflicts_to_qf, {})
end

return M
