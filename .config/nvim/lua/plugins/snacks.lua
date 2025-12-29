return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {},
  keys = {
    {
      '<leader>jj',
      function()
        Snacks.terminal('jjui', { win = { position = 'float', width = 0.9999, height = 0.99999 } })
      end,
      desc = 'Toggle Terminal',
    },
  },
}
