function SalTor_map(mode, keys, cmd, desc, opts)
  local options = { noremap = true, silent = true, desc = desc }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, keys, cmd, options)
end

function SalTor_map_normal(keys, cmd, desc, opts)
  SalTor_map('n', keys, cmd, desc, opts)
end

function SalTor_map_normal_buffer(keys, cmd, desc, opts)
  local options = { buffer = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  SalTor_map('n', keys, cmd, desc, options)
end
