return {
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('refactoring').setup()
    end,
  },
  { 'tpope/vim-surround' },
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
    opts = { mappings = { basic = true, extra = false } },
    config = function()
      require('Comment').setup()
    end,
  },
  {
    'ThePrimeagen/harpoon',
    config = function()
      local nmap = require('saltor').nmap
      nmap('<leader>na', "<cmd>lua require('harpoon.mark').add_file()<CR>")
      nmap('<leader>nm', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>")

      -- Colemak bindings
      nmap('<leader>nn', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
      nmap('<leader>ne', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
      nmap('<leader>ni', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
      nmap('<leader>no', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")

      -- Qwerty bindings
      nmap('<leader>n1', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>")
      nmap('<leader>n2', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>")
      nmap('<leader>n3', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>")
      nmap('<leader>n4', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>")
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
  -- {
  --   'ggandor/leap.nvim',
  --   config = function()
  --     require('leap').add_default_mappings()
  --   end,
  -- },
}
