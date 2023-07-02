local rt = require("rust-tools")

rt.setup({
	server = {
		on_attach = require("svl.lsp.handlers").on_attach,
	},
	hover_actions = {
		auto_focus = true,
	}
})
