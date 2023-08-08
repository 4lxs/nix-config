local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end
vim.opt.rtp:prepend(lazypath)

local api = vim.api

require('lazy').setup("plugins")
	-- "nvim-lua/plenary.nvim",
	-- "folke/tokyonight.nvim",
	-- "ggandor/leap.nvim",
	-- "nvim-lualine/lualine.nvim",
	-- "lukas-reineke/indent-blankline.nvim",
	-- "lewis6991/impatient.nvim",
	-- "tpope/vim-sleuth",
	-- "kyazdani42/nvim-web-devicons",
	-- "xeluxee/competitest.nvim",
	-- "windwp/nvim-autopairs",
	-- "ThePrimeagen/harpoon",
	-- { "akinsho/bufferline.nvim", tag = "v2.*" },
	-- "folke/neodev.nvim",
	-- "numToStr/Comment.nvim",
	-- "kylechui/nvim-surround",
	-- "folke/which-key.nvim",
	-- "danymat/neogen",

	-- -- better ui
	-- "rcarriga/nvim-notify",
	-- "MunifTanjim/nui.nvim",

	-- -- writing
	-- { "lervag/vimtex", ft = { "tex", "latex" } },
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	run = "cd app && npm install",
	-- 	ft = { "markdown" },
	-- 	setup = 'require("plugins.markdown-preview-setup")',
	-- },

	-- -- lsp (config for all plugins is in lsp.lua)
	-- "onsails/lspkind.nvim",
	-- "williamboman/mason.nvim",
	-- "williamboman/mason-lspconfig.nvim",
	-- "jayp0521/mason-null-ls.nvim",
	-- "jose-elias-alvarez/null-ls.nvim",
	-- "neovim/nvim-lspconfig",
	-- "j-hui/fidget.nvim",
	-- "folke/trouble.nvim",
	-- "simrat39/rust-tools.nvim",

	-- -- debugging
	-- "mfussenegger/nvim-dap",
	-- "rcarriga/nvim-dap-ui",
	-- "jayp0521/mason-nvim-dap.nvim",
	-- "theHamsta/nvim-dap-virtual-text",

	-- -- autocompletion
	-- "hrsh7th/cmp-nvim-lsp",
	-- "hrsh7th/nvim-cmp",
	-- "saadparwaiz1/cmp_luasnip",
	-- "L3MON4D3/LuaSnip",
	-- "hrsh7th/cmp-path",
	-- "hrsh7th/cmp-buffer",
	-- "ray-x/lsp_signature.nvim",
	-- "rafamadriz/friendly-snippets",

	-- -- treesitter
	-- "nvim-treesitter/nvim-treesitter-textobjects",
	-- "nvim-treesitter/nvim-treesitter-context",
	-- "andymass/vim-matchup",
	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	run = function()
	-- 		require("nvim-treesitter.install").update({ with_sync = true })
	-- 	end,
	-- },
	-- "nvim-treesitter/playground",
	-- { "yioneko/nvim-yati", tag = "*" },

	-- -- telescope
	-- { "nvim-telescope/telescope.nvim", tag = "0.1.0" },
	-- "nvim-telescope/telescope-fzy-native.nvim",

	-- -- tmux nvim integration
	-- "christoomey/vim-tmux-navigator",
	-- "vimpostor/vim-tpipeline",

	-- -- notetaking
	-- "renerocksai/telekasten.nvim",

-- return packer.startup(function(use)
-- 	for _, plug in ipairs(plugins) do
-- 		local plugin = type(plug) == "string" and { plug } or plug
-- 		plugin.config = string.format(
-- 			'pcall(require, "plugins.%s")',
-- 			string.gsub(string.lower(string.match(plugin[1], ".+/([^\\.]+)")), "nvim%-", "")
-- 		)
-- 		use(plugin)
-- 	end

-- 	-- first launch
-- 	if is_bootstrap then
-- 		print("Plugins are being installed")
-- 		packer.sync()
-- 	end
-- end)
