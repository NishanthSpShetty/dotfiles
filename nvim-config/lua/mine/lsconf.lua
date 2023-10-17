local nvim_lsp = require("lspconfig")

require("renamer").setup()
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
	buf_set_keymap("n", "U", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", '<cmd>lua require("renamer").rename()<CR>', opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

	--buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gr", '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
	-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.open_float(0, {scope="line"})<CR>', opts)
	-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.open_float(0, {focus=false})<CR>', opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	buf_set_keymap("n", "<space>r", "<cmd>lua vim.lsp.codelens.refresh()<CR>", opts)
	buf_set_keymap("n", "<space>cr", "<cmd>RustHoverActions<CR>", opts)
end
-- add capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = true,
	underline = true,
	signs = true,
})
-- on hover show any line diagnostics
vim.o.updatetime = 250

local servers = {
	"pyright",
	"clangd",
	--     "rust_analyzer",
	"tsserver",
	"gopls",
	"lua_ls",
	--	"haskell-language-server-wrapper",
}

for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

nvim_lsp.hls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		haskell = {
			hlintOn = false,
		},
	},
})

-- additional lsp server config
require("rust-tools").setup({
	tools = {
		autoSetHints = true,
		runnables = { use_telescope = true },
		inlay_hints = { show_parameter_hints = true },
		hover_actions = { auto_focus = true },
	},
	server = {
		on_attach = on_attach,
	},
	--	dap = {
	--		adapter = {
	--			type = "executable",
	--			command = "lldb-vscode",
	--			name = "rt_lldb",
	--		},
	--	},
})

local function elixirLsp()
	local elixir = require("elixir")

	-- setup when the mix project is present
	local cwd = vim.loop.cwd()
	local mix_exs_fullpath = table.concat({ cwd, "mix.exs" }, "/")
	local file_exists = not vim.tbl_isempty(vim.loop.fs_stat(mix_exs_fullpath) or {})

	if file_exists then
		elixir.setup({
			cmd = { "/home/nishanth/.elixir-ls/release/language_server.sh" },
			on_attach = on_attach,
			capabilities = capabilities,
			settings = elixir.settings({
				dialyzerEnabled = true,
				fetchDeps = true,
			}),
		})
	end
end

elixirLsp()
