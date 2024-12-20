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

vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

require('lazy').setup({
  {
    'tpope/vim-fugitive',
    config = function()
      require('saltor').nmap('<leader>gs', '<cmd>Git<CR>')
    end,
  },
  'tpope/vim-rhubarb',

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    opts = function()
      return {
        window = {
          completion = require('cmp').config.window.bordered(),
        },
        sources = {},
      }
    end,
  },

  { 'folke/which-key.nvim', opts = {} },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'navarasu/onedark.nvim', -- Theme inspired by Atom
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = 'make install_jsregexp',
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-live-grep-args.nvim',
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = '^1.0.0',
      },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-o>'] = function(p_bufnr)
                actions.send_selected_to_qflist(p_bufnr)
                vim.cmd.cfdo 'edit'
              end,
            },
          },
        },
      }

      telescope.load_extension 'live_grep_args'

      -- Enable telescope fzf native, if installed
      pcall(telescope.load_extension, 'fzf')

      local builtin = require 'telescope.builtin'
      local themes = require 'telescope.themes'
      local nmap = require('saltor').nmap
      local map = require('saltor').map
      local searchProject = require('saltor').searchProject

      nmap('<leader>sp', ':Telescope live_grep<CR>', 'Search project')
      nmap('<leader>sf', function()
        builtin.current_buffer_fuzzy_find(themes.get_ivy { previewer = false })
      end, '[/] Fuzzily search in current buffer')

      nmap('<leader>gf', builtin.git_files, 'Search [G]it [F]iles')
      nmap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
      nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      map('v', '<leader>sp', searchProject, 'Search project (selection)')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { import = 'custom.plugins' },
}, {})

vim.cmd.colorscheme 'catppuccin-frappe'

-- [[ Setting options ]]

vim.o.hlsearch = false -- Set highlight on search
vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'supermaven', group_index = 2 },
    { name = 'nvim_lsp', group_index = 1, max_item_count = 15 },
    { name = 'vsnip', group_index = 2 },
    { name = 'buffer', keyword_length = 4, group_index = 2 },
    { name = 'path', group_index = 2 },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
require 'custom/my-customizations'
