-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/svl/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/svl/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/svl/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/svl/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/svl/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { 'pcall(require, "plugins.comment")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { 'pcall(require, "plugins.luasnip")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufferline.nvim"] = {
    config = { 'pcall(require, "plugins.bufferline")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    config = { 'pcall(require, "plugins.cmp-buffer")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    config = { 'pcall(require, "plugins.cmp-lsp")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    config = { 'pcall(require, "plugins.cmp-path")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    config = { 'pcall(require, "plugins.cmp_luasnip")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["competitest.nvim"] = {
    config = { 'pcall(require, "plugins.competitest")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/competitest.nvim",
    url = "https://github.com/xeluxee/competitest.nvim"
  },
  ["fidget.nvim"] = {
    config = { 'pcall(require, "plugins.fidget")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["friendly-snippets"] = {
    config = { 'pcall(require, "plugins.friendly-snippets")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  harpoon = {
    config = { 'pcall(require, "plugins.harpoon")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["impatient.nvim"] = {
    config = { 'pcall(require, "plugins.impatient")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { 'pcall(require, "plugins.indent-blankline")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["leap.nvim"] = {
    config = { 'pcall(require, "plugins.leap")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/leap.nvim",
    url = "https://github.com/ggandor/leap.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { 'pcall(require, "plugins.lsp_signature")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind.nvim"] = {
    config = { 'pcall(require, "plugins.lspkind")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    config = { 'pcall(require, "plugins.lualine")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    config = { 'pcall(require, "plugins.markdown-preview")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/svl/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    config = { 'pcall(require, "plugins.mason-lspconfig")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason-null-ls.nvim"] = {
    config = { 'pcall(require, "plugins.mason-null-ls")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/mason-null-ls.nvim",
    url = "https://github.com/jayp0521/mason-null-ls.nvim"
  },
  ["mason-nvim-dap.nvim"] = {
    config = { 'pcall(require, "plugins.mason-dap")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/mason-nvim-dap.nvim",
    url = "https://github.com/jayp0521/mason-nvim-dap.nvim"
  },
  ["mason.nvim"] = {
    config = { 'pcall(require, "plugins.mason")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["neodev.nvim"] = {
    config = { 'pcall(require, "plugins.neodev")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/neodev.nvim",
    url = "https://github.com/folke/neodev.nvim"
  },
  neogen = {
    config = { 'pcall(require, "plugins.neogen")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["nui.nvim"] = {
    config = { 'pcall(require, "plugins.nui")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["null-ls.nvim"] = {
    config = { 'pcall(require, "plugins.null-ls")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { 'pcall(require, "plugins.autopairs")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { 'pcall(require, "plugins.cmp")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    config = { 'pcall(require, "plugins.dap")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { 'pcall(require, "plugins.dap-ui")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { 'pcall(require, "plugins.dap-virtual-text")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    config = { 'pcall(require, "plugins.lspconfig")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { 'pcall(require, "plugins.notify")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { 'pcall(require, "plugins.surround")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-treesitter"] = {
    config = { 'pcall(require, "plugins.treesitter")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    config = { 'pcall(require, "plugins.treesitter-context")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { 'pcall(require, "plugins.treesitter-textobjects")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    config = { 'pcall(require, "plugins.web-devicons")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-yati"] = {
    config = { 'pcall(require, "plugins.yati")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/nvim-yati",
    url = "https://github.com/yioneko/nvim-yati"
  },
  ["packer.nvim"] = {
    config = { 'pcall(require, "plugins.packer")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    config = { 'pcall(require, "plugins.playground")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    config = { 'pcall(require, "plugins.plenary")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { 'pcall(require, "plugins.rust-tools")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telekasten.nvim"] = {
    config = { 'pcall(require, "plugins.telekasten")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/telekasten.nvim",
    url = "https://github.com/renerocksai/telekasten.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    config = { 'pcall(require, "plugins.telescope-fzy-native")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { 'pcall(require, "plugins.telescope")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { 'pcall(require, "plugins.tokyonight")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { 'pcall(require, "plugins.trouble")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-matchup"] = {
    config = { 'pcall(require, "plugins.vim-matchup")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-sleuth"] = {
    config = { 'pcall(require, "plugins.vim-sleuth")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-tmux-navigator"] = {
    config = { 'pcall(require, "plugins.vim-tmux-navigator")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-tpipeline"] = {
    config = { 'pcall(require, "plugins.vim-tpipeline")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/vim-tpipeline",
    url = "https://github.com/vimpostor/vim-tpipeline"
  },
  vimtex = {
    config = { 'pcall(require, "plugins.vimtex")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/svl/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["which-key.nvim"] = {
    config = { 'pcall(require, "plugins.which-key")' },
    loaded = true,
    path = "/home/svl/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: markdown-preview.nvim
time([[Setup for markdown-preview.nvim]], true)
require("plugins.markdown-preview-setup")
time([[Setup for markdown-preview.nvim]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
pcall(require, "plugins.rust-tools")
time([[Config for rust-tools.nvim]], false)
-- Config for: plenary.nvim
time([[Config for plenary.nvim]], true)
pcall(require, "plugins.plenary")
time([[Config for plenary.nvim]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
pcall(require, "plugins.bufferline")
time([[Config for bufferline.nvim]], false)
-- Config for: neodev.nvim
time([[Config for neodev.nvim]], true)
pcall(require, "plugins.neodev")
time([[Config for neodev.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
pcall(require, "plugins.web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
pcall(require, "plugins.surround")
time([[Config for nvim-surround]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
pcall(require, "plugins.comment")
time([[Config for Comment.nvim]], false)
-- Config for: nvim-treesitter-context
time([[Config for nvim-treesitter-context]], true)
pcall(require, "plugins.treesitter-context")
time([[Config for nvim-treesitter-context]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
pcall(require, "plugins.notify")
time([[Config for nvim-notify]], false)
-- Config for: cmp_luasnip
time([[Config for cmp_luasnip]], true)
pcall(require, "plugins.cmp_luasnip")
time([[Config for cmp_luasnip]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
pcall(require, "plugins.lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-dap-virtual-text
time([[Config for nvim-dap-virtual-text]], true)
pcall(require, "plugins.dap-virtual-text")
time([[Config for nvim-dap-virtual-text]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
pcall(require, "plugins.null-ls")
time([[Config for null-ls.nvim]], false)
-- Config for: cmp-path
time([[Config for cmp-path]], true)
pcall(require, "plugins.cmp-path")
time([[Config for cmp-path]], false)
-- Config for: nui.nvim
time([[Config for nui.nvim]], true)
pcall(require, "plugins.nui")
time([[Config for nui.nvim]], false)
-- Config for: telekasten.nvim
time([[Config for telekasten.nvim]], true)
pcall(require, "plugins.telekasten")
time([[Config for telekasten.nvim]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
pcall(require, "plugins.mason")
time([[Config for mason.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
pcall(require, "plugins.dap")
time([[Config for nvim-dap]], false)
-- Config for: playground
time([[Config for playground]], true)
pcall(require, "plugins.playground")
time([[Config for playground]], false)
-- Config for: mason-nvim-dap.nvim
time([[Config for mason-nvim-dap.nvim]], true)
pcall(require, "plugins.mason-dap")
time([[Config for mason-nvim-dap.nvim]], false)
-- Config for: nvim-yati
time([[Config for nvim-yati]], true)
pcall(require, "plugins.yati")
time([[Config for nvim-yati]], false)
-- Config for: mason-null-ls.nvim
time([[Config for mason-null-ls.nvim]], true)
pcall(require, "plugins.mason-null-ls")
time([[Config for mason-null-ls.nvim]], false)
-- Config for: telescope-fzy-native.nvim
time([[Config for telescope-fzy-native.nvim]], true)
pcall(require, "plugins.telescope-fzy-native")
time([[Config for telescope-fzy-native.nvim]], false)
-- Config for: mason-lspconfig.nvim
time([[Config for mason-lspconfig.nvim]], true)
pcall(require, "plugins.mason-lspconfig")
time([[Config for mason-lspconfig.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
pcall(require, "plugins.treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
pcall(require, "plugins.telescope")
time([[Config for telescope.nvim]], false)
-- Config for: neogen
time([[Config for neogen]], true)
pcall(require, "plugins.neogen")
time([[Config for neogen]], false)
-- Config for: friendly-snippets
time([[Config for friendly-snippets]], true)
pcall(require, "plugins.friendly-snippets")
time([[Config for friendly-snippets]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
pcall(require, "plugins.which-key")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-treesitter-textobjects
time([[Config for nvim-treesitter-textobjects]], true)
pcall(require, "plugins.treesitter-textobjects")
time([[Config for nvim-treesitter-textobjects]], false)
-- Config for: lspkind.nvim
time([[Config for lspkind.nvim]], true)
pcall(require, "plugins.lspkind")
time([[Config for lspkind.nvim]], false)
-- Config for: vim-tpipeline
time([[Config for vim-tpipeline]], true)
pcall(require, "plugins.vim-tpipeline")
time([[Config for vim-tpipeline]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
pcall(require, "plugins.lsp_signature")
time([[Config for lsp_signature.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
pcall(require, "plugins.cmp")
time([[Config for nvim-cmp]], false)
-- Config for: leap.nvim
time([[Config for leap.nvim]], true)
pcall(require, "plugins.leap")
time([[Config for leap.nvim]], false)
-- Config for: vim-tmux-navigator
time([[Config for vim-tmux-navigator]], true)
pcall(require, "plugins.vim-tmux-navigator")
time([[Config for vim-tmux-navigator]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
pcall(require, "plugins.indent-blankline")
time([[Config for indent-blankline.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
pcall(require, "plugins.luasnip")
time([[Config for LuaSnip]], false)
-- Config for: impatient.nvim
time([[Config for impatient.nvim]], true)
pcall(require, "plugins.impatient")
time([[Config for impatient.nvim]], false)
-- Config for: vim-sleuth
time([[Config for vim-sleuth]], true)
pcall(require, "plugins.vim-sleuth")
time([[Config for vim-sleuth]], false)
-- Config for: vim-matchup
time([[Config for vim-matchup]], true)
pcall(require, "plugins.vim-matchup")
time([[Config for vim-matchup]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
pcall(require, "plugins.dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
pcall(require, "plugins.trouble")
time([[Config for trouble.nvim]], false)
-- Config for: cmp-nvim-lsp
time([[Config for cmp-nvim-lsp]], true)
pcall(require, "plugins.cmp-lsp")
time([[Config for cmp-nvim-lsp]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
pcall(require, "plugins.tokyonight")
time([[Config for tokyonight.nvim]], false)
-- Config for: cmp-buffer
time([[Config for cmp-buffer]], true)
pcall(require, "plugins.cmp-buffer")
time([[Config for cmp-buffer]], false)
-- Config for: fidget.nvim
time([[Config for fidget.nvim]], true)
pcall(require, "plugins.fidget")
time([[Config for fidget.nvim]], false)
-- Config for: packer.nvim
time([[Config for packer.nvim]], true)
pcall(require, "plugins.packer")
time([[Config for packer.nvim]], false)
-- Config for: competitest.nvim
time([[Config for competitest.nvim]], true)
pcall(require, "plugins.competitest")
time([[Config for competitest.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
pcall(require, "plugins.lualine")
time([[Config for lualine.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
pcall(require, "plugins.autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: harpoon
time([[Config for harpoon]], true)
pcall(require, "plugins.harpoon")
time([[Config for harpoon]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType latex ++once lua require("packer.load")({'vimtex'}, { ft = "latex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/svl/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
