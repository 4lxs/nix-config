local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
	is_bootstrap = true
end

local api = vim.api
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Highlight on yank
local rpcGrp = api.nvim_create_augroup("ReloadPackerConfig", { clear = true })
api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*/plugins/init.lua" },
	callback = packer.sync,
	group = rpcGrp,
})

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local plugins = {
	"wbthomason/packer.nvim",
	"nvim-lua/plenary.nvim",
	"folke/tokyonight.nvim",
	"ggandor/leap.nvim",
	"nvim-lualine/lualine.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/impatient.nvim",
	"tpope/vim-sleuth",
	"kyazdani42/nvim-web-devicons",
	"xeluxee/competitest.nvim",
	"windwp/nvim-autopairs",
	"ThePrimeagen/harpoon",
	{ "akinsho/bufferline.nvim", tag = "v2.*" },
	"folke/neodev.nvim",
	"numToStr/Comment.nvim",
	"kylechui/nvim-surround",
	"folke/which-key.nvim",
	"danymat/neogen",

	-- better ui
	"rcarriga/nvim-notify",
	"MunifTanjim/nui.nvim",

	-- writing
	{ "lervag/vimtex", ft = { "tex", "latex" } },
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = { "markdown" },
		setup = 'require("plugins.markdown-preview-setup")',
	},

	-- lsp (config for all plugins is in lsp.lua)
	"onsails/lspkind.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jayp0521/mason-null-ls.nvim",
	"jose-elias-alvarez/null-ls.nvim",
	"neovim/nvim-lspconfig",
	"j-hui/fidget.nvim",
	"folke/trouble.nvim",
	"simrat39/rust-tools.nvim",

	-- debugging
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"jayp0521/mason-nvim-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",

	-- autocompletion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/nvim-cmp",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"ray-x/lsp_signature.nvim",
	"rafamadriz/friendly-snippets",

	-- treesitter
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-context",
	"andymass/vim-matchup",
	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	"nvim-treesitter/playground",
	{ "yioneko/nvim-yati", tag = "*" },

	-- telescope
	{ "nvim-telescope/telescope.nvim", tag = "0.1.0" },
	"nvim-telescope/telescope-fzy-native.nvim",

	-- tmux nvim integration
	"christoomey/vim-tmux-navigator",
	"vimpostor/vim-tpipeline",

	-- notetaking
	"renerocksai/telekasten.nvim",
}

return packer.startup(function(use)
	for _, plug in ipairs(plugins) do
		local plugin = type(plug) == "string" and { plug } or plug
		plugin.config = string.format(
			'pcall(require, "plugins.%s")',
			string.gsub(string.lower(string.match(plugin[1], ".+/([^\\.]+)")), "nvim%-", "")
		)
		use(plugin)
	end

	-- first launch
	if is_bootstrap then
		print("Plugins are being installed")
		packer.sync()
	end
end)
