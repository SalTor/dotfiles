local actions = require('telescope.actions')
-- Global remapping
-------------------
require('telescope').setup{
    defaults = {
        prompt_position = "top",
        sorting_strategy = "ascending",
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
            }
        },
    }
}
