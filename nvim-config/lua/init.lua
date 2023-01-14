-- import all user defined and remote plugin here
require("mine.cmd")

require("lualine").setup()

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

require("mine.lsconf")
require("Comment").setup()
require("mine.luasnp")
require("mine.tsitter")
require("mine.utils")
require("mine.luaformt")
require("mine.dap")

require("telescope").load_extension("dap")

require("dressing").setup({
    select = {
        get_config = function(opts)
            if opts.kind == "codeaction" then
                return {
                    backend = "nui",
                    nui = {
                        relative = "cursor",
                        max_width = 40,
                    },
                }
            end
        end,
    },
})

require("noice").setup()
