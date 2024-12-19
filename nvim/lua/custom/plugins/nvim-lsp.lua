return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim', -- Automatically install LSPs to stdpath for neovim

    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} }, -- Useful status updates for LSP

    'folke/neodev.nvim', -- Additional lua configuration, makes nvim stuff amazing!
  },
}
