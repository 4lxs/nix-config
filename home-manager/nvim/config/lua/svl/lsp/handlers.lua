local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = {
			severity = { min = vim.diagnostic.severity.WARN }
		},
		underline = {
			severity = { min = vim.diagnostic.severity.WARN }
		},
		signs = true,
		update_in_insert = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr }
	local keymap = vim.keymap.set
	keymap("n", "gD", vim.lsp.buf.declaration, opts)
	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gI", vim.lsp.buf.implementation, opts)
	-- keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "gl", vim.diagnostic.open_float, opts)
	keymap("n", "<leader>lf", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
	keymap("n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap("n", "<leader>la", vim.lsp.buf.code_action, opts)
	keymap("n", "<leader>lj", function()
		vim.diagnostic.goto_next({ buffer = 0 })
	end, opts)
	keymap("n", "<leader>lk", function()
		vim.diagnostic.goto_prev({ buffer = 0 })
	end, opts)
	keymap("n", "<leader>lr", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, opts)
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, opts)
end

M.on_attach = function(client, bufnr)
	if client.name == "sumneko_lua" or client.name == "pyright" or client.name == "marksman" then
		client.server_capabilities.documentFormattingProvider = false
	end

	if client.name == "rust_analyzer" then
		local rt = require("rust-tools")
		-- Hover actions
		vim.keymap.set("n", "<c-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		-- Code action groups
		vim.keymap.set("n", "<leader>lg", rt.code_action_group.code_action_group, { buffer = bufnr })
	end

	lsp_keymaps(bufnr)

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end
end

return M
