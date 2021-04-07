local actions = require('telescope.actions')
-- Global remapping
-------------------
require('telescope').setup{
    defaults = {
        file_sorter = require('telescope.sorters').get_fzy_sorter,
        color_devicons = true,
        prompt_position = 'top',
        sorting_strategy = 'ascending',

        mappings = {
            i = {
                ['<ESC>'] = actions.close,
                ['<C-u>'] = false
            }
        },

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    },
}

require('nvim-web-devicons').setup{
    default = true
}
