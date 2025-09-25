local nmap = require('saltor').nmap

return {
  {
    'tpope/vim-fugitive',
    config = function()
      -- nmap('<leader>gs', '<cmd>Git<CR>')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      local gitsigns = require 'gitsigns'

      gitsigns.setup {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
      }

      nmap(']h', gitsigns.next_hunk, 'Next hunk')
      nmap('[h', gitsigns.prev_hunk, 'Prev hunk')
      nmap('<leader>gb', gitsigns.blame_line, 'Git blame')
    end,
  },
  {
    'algmyr/vcmarkers.nvim',
    config = function()
      require('vcmarkers').setup {}

      local function nextConflict()
        require('vcmarkers').actions.next_marker(0, vim.v.count1)
      end

      local function prevConflict()
        require('vcmarkers').actions.prev_marker(0, vim.v.count1)
      end

      local function selectSection()
        require('vcmarkers').actions.select_section(0)
      end

      local function foldOutsideMarkers()
        require('vcmarkers').fold.toggle(0)
      end

      local function cycleMarkerStyle()
        require('vcmarkers').actions.cycle_marker(0)
      end

      nmap('<leader>m]', nextConflict, 'Go to next marker')
      nmap('<leader>m[', prevConflict, 'Go to previous marker')
      nmap('<leader>ms', selectSection, 'Select the section under the cursor')
      nmap('<leader>mf', foldOutsideMarkers, 'Fold outside markers')
      nmap('<leader>mc', cycleMarkerStyle, 'Cycle marker representations')
    end,
  },
  {
    'rafikdraoui/jj-diffconflicts',
  },
  {
    'julienvincent/hunk.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-mini/mini.icons',
    },
    cmd = { 'DiffEditor' },
    config = function()
      local hunk = require 'hunk'
      hunk.setup {
        keys = {
          global = {
            quit = { 'q' },
            accept = { '<leader><Cr>' },
            focus_tree = { '<leader>e' },
          },

          tree = {
            expand_node = { 'l', '<Right>' },
            collapse_node = { 'h', '<Left>' },

            open_file = { '<Cr>' },

            toggle_file = { 'a' },
          },

          diff = {
            toggle_hunk = { 'A' },
            toggle_line = { 'a' },
            -- This is like toggle_line but it will also toggle the line on the other
            -- 'side' of the diff.
            toggle_line_pair = { 's' },

            prev_hunk = { '[h' },
            next_hunk = { ']h' },

            -- Jump between the left and right diff view
            toggle_focus = { '<Tab>' },
          },
        },

        ui = {
          tree = {
            -- Mode can either be `nested` or `flat`
            mode = 'nested',
            width = 35,
          },
          --- Can be either `vertical` or `horizontal`
          layout = 'vertical',
        },

        icons = {
          selected = '󰡖',
          deselected = '',
          partially_selected = '󰛲',

          folder_open = '',
          folder_closed = '',
        },

        -- Called right after each window and buffer are created.
        hooks = {
          ---@param _context { buf: number, tree: NuiTree, opts: table }
          on_tree_mount = function(_context) end,
          ---@param _context { buf: number, win: number }
          on_diff_mount = function(_context) end,
        },
      }
    end,
  },
}
