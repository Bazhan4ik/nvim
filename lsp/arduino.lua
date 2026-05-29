---@type vim.lsp.Config

local MY_FQBN = "esp32:esp32:esp32"

return {
  filetypes = { 'arduino' },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
	local root = vim.fs.root(fname, { '*.ino' })
		or vim.fn.fnamemodify(fname, ':h')
    on_dir(root)
  end,
  cmd = {
    'arduino-language-server',
	'-clangd', '/usr/bin/clangd',
	'-cli', '/opt/homebrew/bin/arduino-cli',
	'-cli-config', '/Users/chud/Library/Arduino15/arduino-cli.yaml',
	'-fqbn', MY_FQBN
  },
  capabilities = {
    textDocument = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL,
    },
    workspace = {
      ---@diagnostic disable-next-line: assign-type-mismatch
      semanticTokens = vim.NIL,
    },
  },
}
