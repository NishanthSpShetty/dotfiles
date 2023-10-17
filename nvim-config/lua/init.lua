-- import all user defined and remote plugin here
require("mine.cmd")

require("lualine").setup()

require("nvim-tree").setup({
    view = {
        side = "left",
        width = 30,
    },
    system_open = {
        cmd = nil,
    },
})

require("renamer").setup()

require("mine.lsconf")
require("Comment").setup()
require("mine.luasnp")
require("mine.tsitter")
require("mine.utils")
require("mine.luaformt")
require("mine.dap")
require("lspsaga").setup({})

require("telescope").load_extension("dap")

require("dressing").setup({

    select = {
        get_config = function(opts)
            if opts.kind == "codeaction" then
                return {
                    backend = "nui",
                    nui = {
                        --						relative = "cursor",
                        max_width = 40,
                    },
                }
            end
        end,
    },
})

local function open_nvim_tree()
    -- open the tree
    require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
