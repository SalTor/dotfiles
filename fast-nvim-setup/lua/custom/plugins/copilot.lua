return {
  "zbirenbaum/copilot.lua",
  -- cmd = "Copilot",
  -- event = "InsertEnter",
  config = function()
    require('copilot').setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
      -- panel = {
      --   enabled = true,
      --   auto_refresh = false,
      --   keymap = {
      --     jump_prev = "[[",
      --     jump_next = "]]",
      --     accept = "<CR>",
      --     refresh = "gr",
      --     open = "<M-CR>"
      --   },
      --   layout = {
      --     position = "bottom", -- | top | left | right
      --     ratio = 0.4
      --   },
      -- },
      -- suggestion = {
      --   enabled = false,
      --   auto_trigger = true,
      --   debounce = 75,
      --   keymap = {
      --     accept = "¬",
      --     accept_word = false,
      --     accept_line = false,
      --     next = "˜",
      --     prev = "π",
      --     dismiss = "≈",
      --   },
      -- },
      -- filetypes = {
      --   yaml = false,
      --   markdown = false,
      --   help = false,
      --   gitcommit = false,
      --   gitrebase = false,
      --   hgcommit = false,
      --   svn = false,
      --   cvs = false,
      --   typescript = true,
      --   ["."] = false,
      -- },
      -- copilot_node_command = 'node', -- Node.js version must be > 18.x
      -- server_opts_overrides = {},
    })
  end
}
