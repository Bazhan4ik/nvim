-- bootstrap lazy.nvim, LazyVim and your plugins
vim.o.termguicolors = true
require("config.lazy")
require("lazy").setup("plugins")


vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities()
})
vim.lsp.enable({ "pyright", "lua_ls" })


require("catppuccin").setup({
	flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin-mocha")


vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3a3d4e" })
vim.api.nvim_set_hl(0, "IblScopeIndent", { fg = "#666875" })

require("ibl").setup {
	indent = {
		highlight = { "IblIndent" },
	},
	scope = {
		highlight = { "IblScopeIndent" },
		enabled = true,
		show_start = true,
		show_end = false,
	}
}




require("nvim-treesitter").install({ "lua" })
require("nvim-treesitter").setup({
	ensure_installed = { "lua", "python" },
	install_dir = vim.fn.stdpath("data") .. "/site",
	auto_install = true,
	highlight = { enable = true, },
	indent = { enable = true }
})


-- Folding that shows how many lines are folded
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

require("ufo").setup({
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  󰁂 %d lines"):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0

		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				table.insert(newVirtText, { chunkText, chunk[2] })
				chunkWidth = targetWidth - curWidth
				break
			end
			curWidth = curWidth + chunkWidth
		end

	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
	end,
})


require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true
	},
	float = {
		padding = 5,
		border = "rounded",
		max_width = 40,
	}
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.opt.number = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false
