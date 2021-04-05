require('nvim-treesitter.configs').setup{
    ensure_installed = { "typescript", "javascript", "html", "python" },
    highlight = {
        enable = false,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gsi",
            node_incremental = "gsn",
            node_decremental = "gsp",
        },
    },
}
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.html.used_by = "htmldjango"
