return {
  {
    'tpope/vim-fugitive',
    config = function()
      local nmap = require('saltor').nmap
      -- nmap('<leader>gs', '<cmd>Git<CR>')
      nmap('<leader>gb', '<cmd>Git blame<CR>')
    end,
  },
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
}
