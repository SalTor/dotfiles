return {
  {
    'tpope/vim-surround',
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      require 'saltor'
      local nmap = SalTor_map_normal
      nmap('<leader>ha', "<cmd>lua require('harpoon.mark').add_file()<CR>")
      nmap('<leader>hl', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")
      nmap('<leader>nm', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

      nmap('<leader>h1', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
      nmap('<leader>nn', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")

      nmap('<leader>h2', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
      nmap('<leader>ne', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")

      nmap('<leader>h3', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
      nmap('<leader>ni', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")

      nmap('<leader>h4', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
      nmap('<leader>no', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
    end,
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
}
