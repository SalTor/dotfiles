return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  },
  config = true,
  init = function()
    require('saltor')
    local nmap = SalTor_map_normal
    nmap('<leader>gs', '<cmd>Neogit<CR>')
  end
}
