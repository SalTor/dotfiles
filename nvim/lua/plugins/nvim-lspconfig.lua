local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local telescopeBuiltin = require 'telescope.builtin'

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('gra', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('grr', telescopeBuiltin.lsp_references, '[G]oto [R]eferences')
  nmap('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('g0', vim.lsp.buf.document_symbol, 'Document Symbol')

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ws', telescopeBuiltin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>,', telescopeBuiltin.git_files, 'File finder')
  nmap('<leader>/', telescopeBuiltin.buffers, 'Buffers')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  nmap('<lader>ff', ':Format<CR>', 'Format buffer')
end

return {
  'neovim/nvim-lspconfig',
  config = function() end,
}
