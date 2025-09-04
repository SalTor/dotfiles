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
}
