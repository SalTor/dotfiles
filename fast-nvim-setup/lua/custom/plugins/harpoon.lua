return {
  "ThePrimeagen/harpoon",
  config = function ()
    require('saltor')
    local nmap = SalTor_map_normal
    nmap("<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<CR>")
    nmap("<leader>hl", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
    nmap("<leader>nm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

    nmap("<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
    nmap("<leader>nn", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")

    nmap("<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
    nmap("<leader>ne", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")

    nmap("<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
    nmap("<leader>ni", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")

    nmap("<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
    nmap("<leader>no", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
  end
}
