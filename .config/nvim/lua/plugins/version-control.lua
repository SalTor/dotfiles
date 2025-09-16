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

      nmap('<leader>m]', function()
        require('vcmarkers').actions.next_marker(0, vim.v.count1)
      end, 'Go to next marker')
      nmap('<leader>m[', function()
        require('vcmarkers').actions.prev_marker(0, vim.v.count1)
      end, 'Go to previous marker')
      nmap('<leader>ms', function()
        require('vcmarkers').actions.select_section(0)
      end, 'Select the section under the cursor')
      nmap('<leader>mf', function()
        require('vcmarkers').fold.toggle(0)
      end, 'Fold outside markers')
      nmap('<leader>mc', function()
        require('vcmarkers').actions.cycle_marker(0)
      end, 'Cycle marker representations')
    end,
  },
}
