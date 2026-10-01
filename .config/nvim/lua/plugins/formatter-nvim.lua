return {
  'mhartington/formatter.nvim',
  config = function()
    local util = require 'formatter.util'

    -- Without this, prettierd formats with its bundled prettier in repos that
    -- don't use prettier at all (e.g. redwood, which uses oxfmt).
    vim.env.PRETTIERD_LOCAL_PRETTIER_ONLY = '1'

    -- oxfmt when the project has an .oxfmtrc, prettierd otherwise
    local function js_formatter()
      local path = util.get_current_buffer_file_path()
      local rc = vim.fs.find({ '.oxfmtrc.json', '.oxfmtrc.jsonc' }, { upward = true, path = vim.fs.dirname(path) })[1]
      if rc then
        local root = vim.fs.dirname(rc)
        local oxfmt = root .. '/node_modules/.bin/oxfmt'
        if vim.fn.executable(oxfmt) == 1 then
          return {
            exe = oxfmt,
            args = { '--stdin-filepath', util.escape_path(path) },
            stdin = true,
            cwd = root,
          }
        end
      end
      return require('formatter.defaults.prettierd')()
    end

    local formatterGroup = vim.api.nvim_create_augroup('FormatAutogroup', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      pattern = '*',
      command = 'FormatWrite',
      group = formatterGroup,
    })

    require('formatter').setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
          -- "formatter.filetypes.lua" defines default configurations for the
          -- "lua" filetype
          require('formatter.filetypes.lua').stylua,

          -- You can also define your own configuration
          function()
            -- Supports conditional formatting
            if util.get_current_buffer_file_name() == 'special.lua' then
              return nil
            end

            -- Full specification of configurations is down below and in Vim help
            -- files
            return {
              exe = 'stylua',
              args = {
                '--search-parent-directories',
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_path()),
                '--',
                '-',
              },
              stdin = true,
            }
          end,
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require('formatter.filetypes.any').remove_trailing_whitespace,
        },

        typescriptreact = {
          js_formatter,
        },

        typescript = {
          js_formatter,
        },

        javascript = {
          js_formatter,
        },

        markdown = {
          js_formatter,
        },

        rust = {
          require('formatter.filetypes.rust').rustfmt(),
        },
        python = {
          require('formatter.filetypes.python').black(),
          require('formatter.filetypes.python').isort(),
        },
      },
    }
  end,
}
