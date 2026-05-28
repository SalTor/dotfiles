return {
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      -- for redshift
      vim.g.db_ui_use_postgres_views = 0
    end,
    config = function()
      -- :DBTableExport [csv|json] [path] + <leader>de in result buffers
      require('dbout-export').setup()
    end,
    keys = {
      { '<leader>da', '<cmd>DBUIToggle<cr>', desc = 'open dbui (dadbod)' },
    },
  },
}
