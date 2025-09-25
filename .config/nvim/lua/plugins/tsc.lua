return {
  'dmmulroy/tsc.nvim',
  config = function()
    local tsc = require 'tsc'
    local nmap = require('saltor').nmap

    tsc.setup()

    nmap('<leader>tc', ':TSC<CR>', 'Run tsc on project')
  end,
}
