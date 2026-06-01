-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
--
-- NOTE: This uses the `main` branch of nvim-treesitter (the rewrite), which is
-- the only branch supported on Neovim 0.12+. The old `master`-branch
-- `require('nvim-treesitter.configs').setup{}` API no longer exists:
--   * highlighting is enabled per-buffer via `vim.treesitter.start()`
--   * parsers are installed via `require('nvim-treesitter').install(...)`
--   * indentation is experimental, opted into via `indentexpr`
--   * `incremental_selection` has no built-in equivalent and was dropped
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      -- Ensure these parsers are installed (async; first run pulls them in).
      require('nvim-treesitter').install {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'typescript',
        'vimdoc',
        'vim',
      }

      -- Enable highlighting + (experimental) indentation for any buffer whose
      -- filetype has an installed parser.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
        callback = function(args)
          if pcall(vim.treesitter.start) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      vim.diagnostic.config {
        float = { border = 'rounded' },
      }

      -- Setup neovim lua configuration
      require('neodev').setup()
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        },
        move = {
          set_jumps = true, -- whether to set jumps in the jumplist
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local swap = require 'nvim-treesitter-textobjects.swap'
      local move = require 'nvim-treesitter-textobjects.move'

      -- Selection text objects (af/if, ac/ic, aa/ia)
      for keys, obj in pairs {
        aa = '@parameter.outer',
        ia = '@parameter.inner',
        af = '@function.outer',
        ['if'] = '@function.inner',
        ac = '@class.outer',
        ic = '@class.inner',
      } do
        vim.keymap.set({ 'x', 'o' }, keys, function()
          select.select_textobject(obj, 'textobjects')
        end)
      end

      -- Swap parameters
      vim.keymap.set('n', '<leader>a', function()
        swap.swap_next '@parameter.inner'
      end)
      vim.keymap.set('n', '<leader>A', function()
        swap.swap_previous '@parameter.inner'
      end)

      -- Movement between functions/classes
      for keys, obj in pairs { [']m'] = '@function.outer', [']]'] = '@class.outer' } do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          move.goto_next_start(obj, 'textobjects')
        end)
      end
      for keys, obj in pairs { [']M'] = '@function.outer', [']['] = '@class.outer' } do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          move.goto_next_end(obj, 'textobjects')
        end)
      end
      for keys, obj in pairs { ['[m'] = '@function.outer', ['[['] = '@class.outer' } do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          move.goto_previous_start(obj, 'textobjects')
        end)
      end
      for keys, obj in pairs { ['[M'] = '@function.outer', ['[]'] = '@class.outer' } do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          move.goto_previous_end(obj, 'textobjects')
        end)
      end
    end,
  },
}
