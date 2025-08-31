return {
  'mason-org/mason-lspconfig.nvim',
  opts = {},
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- Useful status updates for LSP
    'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing!
  },
}
