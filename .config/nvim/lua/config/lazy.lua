vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'folke/which-key.nvim',
    opts = {
      delay = 1000,
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    config = function()
      -- local function in_jj_repo()
      --   local ok = os.execute 'jj --ignore-working-copy root >/dev/null 2>&1'
      --   -- os.execute returns true/nil in Lua 5.4+, or a status code in older versions
      --   return ok == true or ok == 0
      -- end
      --
      -- local function jj_state()
      --   if in_jj_repo() then
      --     local change_id =
      --       io.popen [[ jj log -r @ -n1 --ignore-working-copy --no-graph -T "" --stat | tail -n1 | sd "(\d+) files? changed, (\d+) insertions?\(\+\), (\d+) deletions?\(-\)" ' ${1}m ${2}+ ${3}-' | sd " 0." "" ]]
      --     if change_id then
      --       local result = change_id:read '*a'
      --       change_id:close()
      --       return result
      --     end
      --   else
      --     return ''
      --   end
      -- end
      --
      -- local function jj_description()
      --   if in_jj_repo() then
      --     local first_line = io.popen 'jj --color=never log --ignore-working-copy --no-graph -r @ -T "description.first_line()" 2>/dev/null'
      --     if first_line then
      --       local result = first_line:read '*a'
      --       first_line:close()
      --       if type(result) == 'string' and string.len(result) > 0 then
      --         return result
      --       else
      --         return '(empty)'
      --       end
      --     end
      --   else
      --     return ''
      --   end
      -- end

      require('lualine').setup {
        options = {
          icons_enabled = false,
          theme = 'catppuccin',
          component_separators = '|',
          section_separators = '',
        },
        -- sections = {
        --   lualine_b = { jj_state, jj_description, 'diff', 'diagnostics' },
        -- },
      }
    end,
  },

  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
    dependencies = { 'rafamadriz/friendly-snippets', 'saadparwaiz1/cmp_luasnip' },
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { import = 'plugins' },
}, {})

require 'config.options'
require 'config.lsp'
require 'config.mappings'
require 'config.jujutsu'
