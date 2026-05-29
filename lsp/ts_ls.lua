local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = nil

return {
    capabilities = capabilities,
	filetypes = { "typescript", "javascript" },
	cmd = { "vtsls", "--stdio" }
}
