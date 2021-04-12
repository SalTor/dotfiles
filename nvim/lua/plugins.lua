local fn = vim.fn

local my = function(file) require(file) end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

require('packer').init({
    display = {
        auto_clean = false,
        non_interactive = true
    }
})

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- use 'junegunn/vim-plug'
    use { 'junegunn/fzf', run = vim.fn['fzf#install()'] }
    use { 'junegunn/fzf.vim', config = my('config/fzf') }

    -- Motions and text objects
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'wellle/targets.vim'
    use { 'easymotion/vim-easymotion', config = my('config/easymotion') }
    use 'RRethy/nvim-base16'

    -- Auto-complete ([{, auto-complete markup, comments
    use 'Raimondi/delimitMate'
    use 'mattn/emmet-vim'
    use { 'preservim/nerdcommenter', config = my('config/nerdcommenter') }

    -- Visuals
    use 'neoclide/jsonc.vim'
    use { 'liuchengxu/vim-which-key', config = my('config/whichkey') }
    use { 'mhinz/vim-startify', config = my('config/startify') }
    use 'psliwka/vim-smoothie'
    use { 'norcalli/nvim-colorizer.lua', run = require'colorizer'.setup() }
    use 'wincent/pinnacle' -- I wonder if I can get rid of this by reducing the complexity of my color scheme method
    use 'sheerun/vim-wombat-scheme'
    use 'kyazdani42/nvim-web-devicons'

    -- Navigation aide / visualization
    use { 'scrooloose/nerdtree', config = my('config/nerdtree') }
    use { 'vim-airline/vim-airline', config = my('config/airline') }
    use 'vim-airline/vim-airline-themes'

    -- Terminal aide
    use { 'kassio/neoterm', config = my('config/neoterm') }
    use 'wincent/terminus'

    -- Snippets
    use 'honza/vim-snippets'

    -- Nice to have, don't really need
    use { 'glacambre/firenvim', run = vim.fn['firenvim#install(0)'] }
    use 'christoomey/vim-system-copy'

    -- Intellisense
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = my('config/treesitter')
    }
    use {
        'nvim-telescope/telescope.nvim',
        config = my('config/telescope'),
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    }

    use {
        'mattn/efm-langserver',
        config = my('config/lsp'),
        requires = {
            'neovim/nvim-lspconfig',
            'glepnir/lspsaga.nvim',
            'kosayoda/nvim-lightbulb',
            'hrsh7th/nvim-compe',
        }
    }
end)
