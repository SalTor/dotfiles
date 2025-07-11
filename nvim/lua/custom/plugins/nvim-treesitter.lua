-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = false,

      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
    vim.diagnostic.config {
      float = { border = 'rounded' },
    }

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

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. They will be passed to
    --  the `settings` field of the server config. You must look up that documentation yourself.
    --
    --  If you want to override the default filetypes that your language server will attach to you can
    --  define the property 'filetypes' to the map in question.
    local servers = {
      -- clangd = {},
      -- gopls = {},
      -- pyright = {},
      -- rust_analyzer = {},
      -- tsserver = {},
      -- html = { filetypes = { 'html', 'twig', 'hbs'} },
      emmet_ls = {
        filetypes = { 'html', 'typescriptreact' },
      },

      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },

      tailwindcss = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              -- { '(["\'`][^"\'`]*.*?["\'`])', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., all strings
              { 'cn\\(([^)]*)\\)', '["\'`]([^"\'`]+)["\'`]' }, -- e.g., cn("...")
              { 'tv\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' }, -- e.g., tv("...")
              { 'Styles \\=([^;]*);', "'([^']*)'" }, -- e.g. const nameStyles = '...'
              { 'Styles \\=([^;]*);', '"([^"]*)"' }, -- e.g. const nameStyles = "..."
              { 'Styles \\=([^;]*);', '\\`([^\\`]*)\\`' }, -- e.g. const nameStyles = `...`
              { 'lassName\\=([^;]*);', '"([^"]*)"' }, -- e.g., <MyDiv nameClassName="..." />
            },
          },
        },
      },
    }

    -- Setup neovim lua configuration
    require('neodev').setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        local util = require 'lspconfig/util'

        local handlers = {
          ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
          ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
        }

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
  end,
}
