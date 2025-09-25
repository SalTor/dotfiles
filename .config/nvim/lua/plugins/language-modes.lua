return {
  -- {
  --   'mrcjkb/rustaceanvim',
  -- },
  -- {
  --   'rust-lang/rust.vim',
  --   ft = 'rust',
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end,
  -- },
  {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'mfussenegger/nvim-dap',
    },
    branch = '1.x.x',
  },
  {
    'AckslD/swenv.nvim',
    'linux-cultist/venv-selector.nvim',
    config = function()
      require('venv-selector').setup {
        -- Your options go here
        -- name = "venv",
        -- auto_refresh = false
      }
    end,
  },
}
