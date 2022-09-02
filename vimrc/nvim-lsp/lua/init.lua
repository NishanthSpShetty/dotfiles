-- import all user defined and remote plugin here
require("mine.lsconf")
require("mine.cmd")

require("lualine").setup()
local elixir = require("elixir")
elixir.setup({
	cmd = { "/home/nishanth/.elixir-ls/release/language_server.sh" },
	settings = elixir.settings({
		dialyzerEnabled = true,
		fetchDeps = false,
		enableTestLenses = false,
		suggestSpecs = false,
	}),
})

require("nvim-tree").setup({
	open_on_setup = true,
	view = {
		side = "left",
		width = 30,
	},
	system_open = {
		cmd = nil,
	},
})
require("mine.luasnp")
require("mine.tsitter")
require("mine.utils")
require("mine.luaformt")
