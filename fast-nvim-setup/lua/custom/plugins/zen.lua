return {
  "folke/zen-mode.nvim",
  config = function ()
    require('saltor')
    local nmap = SalTor_map_normal
    nmap("<leader>zz", "<cmd>lua require('zen-mode').toggle({})<CR>")
  end
}
