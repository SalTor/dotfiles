return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'nvim-telescope/telescope.nvim', -- optional
    'sindrets/diffview.nvim', -- optional
  },
  config = true,
  init = function()
    require('saltor').nmap('<leader>gs', require('neogit').open)
  end,
}
