return {
  'dmmulroy/tsc.nvim',
  config = function()
    local tsc = require 'tsc'
    local nmap = require('saltor').nmap

    tsc.setup {
      bin_name = 'tsgo',
    }

    nmap('<leader>tc', ':TSC<CR>', 'Run tsc on project')
  end,
}
