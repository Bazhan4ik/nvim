return {
    cmd = { "pyright-langserver", "--stdio" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "python" }, 
}
