return {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	single_file_support = true,
}
