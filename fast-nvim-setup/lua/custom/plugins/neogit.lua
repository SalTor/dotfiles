require('saltor')

return {
  "andrewcohen/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  },
  config = true,
  init = function()
    local nmap = SalTor_map_normal
    nmap('<leader>gs', '<cmd>Neogit<CR>')
  end
}
