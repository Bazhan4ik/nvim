return {
    cmd = { "lua-language-server" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
	filetypes = { "lua" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            diagnostics = {
                globals = { "vim", "require" },
            },
        },
    },
}
