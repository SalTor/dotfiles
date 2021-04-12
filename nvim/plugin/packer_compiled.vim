" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/Users/sal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/sal/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/sal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/sal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/sal/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  delimitMate = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["efm-langserver"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/efm-langserver"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  firenvim = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/firenvim"
  },
  fzf = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["jsonc.vim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/jsonc.vim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  neoterm = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/neoterm"
  },
  nerdcommenter = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nvim-base16"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-base16"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  pinnacle = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/pinnacle"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  terminus = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/terminus"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-airline-themes"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-easymotion"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-smoothie"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-smoothie"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-system-copy"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-system-copy"
  },
  ["vim-which-key"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-which-key"
  },
  ["vim-wombat-scheme"] = {
    loaded = true,
    path = "/Users/sal/.local/share/nvim/site/pack/packer/start/vim-wombat-scheme"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
