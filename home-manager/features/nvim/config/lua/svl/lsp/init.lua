local ok, _ = pcall(require, 'lspconfig')
if not ok then
    return
end

require('svl.lsp.mason')
require('svl.lsp.handlers').setup()
require('svl.lsp.null-ls')
require("svl.lsp.dap")
require('svl.lsp.rust')
