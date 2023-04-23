local null_ls = require("null-ls")
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting

null_ls.setup({
	debug = false,
	sources = {
		diagnostics.chktex,
		diagnostics.markdownlint,
		formatting.markdownlint,
		formatting.stylua,
		-- diagnostics.pylint,
		-- diagnostics.flake8,
		-- formatting.black,
		-- formatting.isort,
	},
})

require("mason-null-ls").setup({
	automatic_installation = true,
})
