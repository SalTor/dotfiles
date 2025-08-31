local nmap = require('saltor').nmap

local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.diagnostic.config {
  virtual_text = true,
  virtual_lines = false,
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local telescopeBuiltin = require 'telescope.builtin'

    nmap('gd', vim.lsp.buf.definition, 'LSP: [G]oto [D]efinition')
    nmap('grn', vim.lsp.buf.rename, 'LSP: [R]e[n]ame')
    nmap('gra', vim.lsp.buf.code_action, 'LSP: [C]ode [A]ction')
    nmap('grr', telescopeBuiltin.lsp_references, 'LSP: [G]oto [R]eferences')
    nmap('gri', vim.lsp.buf.implementation, 'LSP: [G]oto [I]mplementation')
    nmap('g0', vim.lsp.buf.document_symbol, 'LSP: Document Symbol')

    nmap('<leader>D', vim.lsp.buf.type_definition, 'LSP: Type [D]efinition')
    nmap('<leader>ws', telescopeBuiltin.lsp_dynamic_workspace_symbols, 'LSP: [W]orkspace [S]ymbols')
    nmap('<leader>,', telescopeBuiltin.git_files, 'File finder')
    nmap('<leader>/', telescopeBuiltin.buffers, 'Buffers')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'LSP: Hover Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, 'LSP: [G]oto [D]eclaration')
    -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'LSP: [W]orkspace [A]dd Folder')
    -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'LSP: [W]orkspace [R]emove Folder')
    -- nmap('<leader>wl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, 'LSP: [W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
    nmap('<leader>ff', ':Format<CR>', 'Format buffer')
  end,
})

vim.lsp.config('ts_ls', {
  settings = {
    -- handlers = {},
  },
})

vim.lsp.config('tailwindcss', {
  settings = {
    tailwindcss = {
      tailwindCSS = {
        classFunctions = { 'cva', 'tv', 'cn' },
        experimental = {
          classRegex = {
            -- { '(["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., all strings
            -- { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]+)["\'`]' }, -- e.g., cn("...")
            -- { 'tv\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., tv("...")
            { 'Styles \\=([^;]*);', "'([^']*)'" }, -- e.g. const nameStyles = '...'
            { 'Styles \\=([^;]*);', '"([^"]*)"' }, -- e.g. const nameStyles = "..."
            { 'Styles \\=([^;]*);', '\\`([^\\`]*)\\`' }, -- e.g. const nameStyles = `...`
            -- { 'lassName\\=([^;]*);', '"([^"]*)"' }, -- e.g., <MyDiv nameClassName="..." />
          },
        },
      },
    },
  },
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
-- local servers = {
--   -- clangd = {},
--   -- gopls = {},
--   -- pyright = {},
--   -- rust_analyzer = {},
--   -- tsserver = {},
--   -- html = { filetypes = { 'html', 'twig', 'hbs'} },
--   -- emmet_ls = {
--   --   filetypes = { 'html', 'typescriptreact' },
--   -- },
--
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--     },
--   },
--
-- tailwindcss = {
--   tailwindCSS = {
--     classFunctions = { 'cva', 'tv', 'cn' },
--     experimental = {
--       classRegex = {
--         -- { '(["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., all strings
--         -- { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]+)["\'`]' }, -- e.g., cn("...")
--         -- { 'tv\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., tv("...")
--         { 'Styles \\=([^;]*);', "'([^']*)'" }, -- e.g. const nameStyles = '...'
--         { 'Styles \\=([^;]*);', '"([^"]*)"' }, -- e.g. const nameStyles = "..."
--         { 'Styles \\=([^;]*);', '\\`([^\\`]*)\\`' }, -- e.g. const nameStyles = `...`
--         -- { 'lassName\\=([^;]*);', '"([^"]*)"' }, -- e.g., <MyDiv nameClassName="..." />
--       },
--     },
--   },
-- },
-- }

local thing = {
  function(server_name)
    local util = require 'lspconfig/util'

    if server_name == 'tsserver' then
      local function organize_imports()
        local params = {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = '',
        }
        vim.lsp.buf.execute_command(params)
      end

      require('lspconfig').tsserver.setup {
        handlers = handlers,
        capabilities = capabilities,
        on_attach = on_attach,
        commands = {
          OrganizeImports = {
            organize_imports,
            description = 'Organize Imports',
          },
        },
      }
    elseif server_name == 'rust_analyzer' then
      require('lspconfig').rust_analyzer.setup {
        handlers = handlers,
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'rust' },
        root_dir = util.root_pattern 'Cargo.toml',
        settings = {
          ['rust_analyzer'] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      }
    elseif server_name == 'pylsp' then
      require('lspconfig').pylsp.setup {
        handlers = handlers,
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pylsp = {
            plugins = {
              pylsp_black = { enabled = true },
              isort = { enabled = true, profile = 'black' },
              autopep8 = { enabled = false },
              pycodestyle = { enabled = false },
              -- jedi = {
              --   environment = '/Users/storcivia/code/etl-pipelines',
              -- },
            },
          },
        },
        filetypes = (servers['pylsp'] or {}).filetypes,
      }
    else
      require('lspconfig')[server_name].setup {
        handlers = handlers,
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end
  end,
}
