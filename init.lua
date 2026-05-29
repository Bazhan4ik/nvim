vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"http://github.com/stevearc/oil.nvim",
	"https://github.com/kevinhwang91/nvim-ufo",
	"https://github.com/kevinhwang91/promise-async",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "main" },
	{ src = "https://github.com/hrsh7th/nvim-cmp", version = "main" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp", version = "main" },
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/windwp/nvim-ts-autotag",
	"https://github.com/olrtg/nvim-emmet",
	"https://github.com/windwp/nvim-autopairs"
})


-- show error
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

-- mason
-- loads language protocol servers
require("mason").setup();
-- mason end

local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "emmet" },
	},
})


-- html help
require("nvim-ts-autotag").setup()
local cmp_autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
cmp_autopairs.setup({})
cmp_autopairs.add_rule(Rule(">", "<", {"html", "svelte"}))
-- html end

-- lsp
vim.lsp.enable({
	"lua_ls",
	"html",
	"emmet_ls",
	"ts_ls",
	"svelte",
	"css-ls",
	"arduino",
});
-- lsp end


--
-- catppuccin
require("catppuccin").setup({
	flavour = "mocha",
})
vim.cmd.colorscheme("catppuccin-mocha")
-- catppuccin end
--



--
-- nvim-treesitter
require("nvim-treesitter").setup({
	ensure_installed = {
		"lua",
		"html",
		"typescript",
		"javascript",
		"svelte",
		"css"
	},
	install_dir = vim.fn.stdpath("data") .. "/site",
	auto_install = true,
	highlight = { enable = true, },
	indent = { enable = true }
})
-- svelte
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
	pattern = "*.svelte",
	callback = function()
		vim.treesitter.start(0, "svelte")
	end
})
-- svelte end
-- use nvim-treesitter indent in all files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
-- nvim-treesitter end
--


--
-- oil
require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true
	},
	columns = {
		"icon",
	},
	float = {
		padding = 5,
		border = "rounded",
		max_width = 40,
	}
})
-- press '-' to go up directory
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- oil end
-- 

-- icons for the file explorer
require("mini.icons").setup();
-- icons end


--
-- ufo
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 99

-- show how many lines are folded
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
	provider_selector = function(buftype, filetype, bufnr)
		if filetype == "typescript" then
			return { "treesitter", "indent" }
		end
		return { "lsp", "indent" }
	end
})

-- ufo end
--


-- ibl
-- show tab lines
require("ibl").setup {
	indent = {
	},
	scope = {
		enabled = true,
		show_start = true,
		show_end = false,
	}
}
-- ibl end


-- show lines
vim.opt.number = true
-- relative lines means it shows how many lines to go down or up to reach a specific line
vim.opt.relativenumber = true


vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = false

-- use 'p' to paste instead of '"+p'
vim.opt.clipboard = "unnamedplus"
