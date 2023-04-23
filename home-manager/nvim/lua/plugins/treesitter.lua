require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	sync_install = false,
	auto_install = false,

	highlight = {
		enable = true,
		disable = { "latex" },
		additional_vim_regex_highlighting = false,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},

	indent = {
		enable = true,
		disable = { "python" },
	},
	
	-- for shit python indentation
	yati = {
		enable = true,
		suppress_conflict_warning = true,
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aC"] = "@comment.outer",
				["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = false,
			goto_next_start = {
				["]c"] = "class.outer",
				["]f"] = "function.outer",
			},
			goto_next_end = {
				["]C"] = "class.outer",
				["]F"] = "function.outer",
			},
			goto_previous_start = {
				["[c"] = "class.outer",
				["[f"] = "function.outer",
			},
			goto_previous_end = {
				["[C"] = "class.outer",
				["[F"] = "function.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dc"] = "@class.outer",
			},
		},
	},

	matchup = {
		enable = true,
	},

	playground = {
		enable = true,
	},

	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
