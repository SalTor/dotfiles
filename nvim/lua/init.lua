require('colorizer').setup()

require('lspsaga').init_lsp_saga {
    code_action_prompt = {
        sign = false
    },
    code_action_keys = { quit = '<ESC>', exec = '<CR>' }
}

-- require('config/fzf')
require('config/sneak')
-- require('config/nerdcommenter')
-- require('config/whichkey')
-- require('config/startify')
-- require('config/nerdtree')
-- require('config/airline')
-- require('config/neoterm')
-- require('config/treesitter')
-- require('config/telescope')
-- require('config/lsp-new')
