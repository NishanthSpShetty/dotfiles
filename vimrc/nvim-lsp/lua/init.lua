-- import all user defined and remote plugin here
require("mine.lsconf")
require("mine.cmd")

require("nvim-tree").setup({
	open_on_setup = true,
	view = {
		side = "left",
		width = 30,
		auto_resize = true,
	},
})
require("mine.luasnp")
require("mine.tsitter")
require("mine.utils")
require("mine.luaformt")
