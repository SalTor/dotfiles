return {
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
        layout_strategy = 'flex',
        layout_config = {
          prompt_position = 'bottom',
          width = 0.9,
          height = 0.5,
          horizontal = {
            width = { padding = 0.15 },
          },
          vertical = {
            preview_height = 0.75,
          },
        },
        mappings = {
          n = {
            -- ['<up>'] = false,
            -- ['<down>'] = false,
          },
          i = {
            -- ['<up>'] = false,
            -- ['<down>'] = false,
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = function(p_bufnr)
              actions.smart_send_to_qflist(p_bufnr)
              -- vim.cmd.cfdo 'edit'
              actions.open_qflist(p_bufnr)
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
    map('v', '<leader>sp', searchProject, 'Search project (selection)')
    nmap('<leader>,', function()
      if require('saltor').is_inside_git_repo() then
        builtin.git_files()
      else
        builtin.find_files()
      end
    end, 'File finder')
    nmap('<leader>/', builtin.buffers, 'Buffers')
  end,
}
