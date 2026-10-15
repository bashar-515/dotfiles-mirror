vim.pack.add({ gh("neovim/nvim-lspconfig") })

local lsp = vim.lsp
local capabilities = require("blink.cmp").get_lsp_capabilities()

-- -g @astrojs/language-server: npm
lsp.config("astro", { capabilities = capabilities })
lsp.enable("astro")

-- github.com/docker/docker-language-server/cmd/docker-language-server@latest: mise
lsp.config("docker_language_server", { capabilities = capabilities })
lsp.enable("docker_language_server")

-- lua-language-server: mise
lsp.config("lua_ls", { capabilities = capabilities })
lsp.enable("lua_ls")

-- @prisma/language-server: npm
lsp.config("prismals", { capabilities = capabilities })
lsp.enable("prismals")

-- @tailwindcss/language-server: npm
lsp.config("tailwindcss", { capabilities = capabilities })
lsp.enable("tailwindcss")

-- typescript-language-server typescript: npm
lsp.config("ts_ls", { capabilities = capabilities })
lsp.enable("ts_ls")

local map = vim.keymap.set

local diagnostic = vim.diagnostic

diagnostic.config({
	float = { source = true },
})

map("n", "<leader>d", diagnostic.open_float)
map("n", "[d", diagnostic.goto_prev)
map("n", "]d", diagnostic.goto_next)

local api = vim.api

api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		local buf = vim.lsp.buf

		map("n", "gD", buf.declaration, opts)
		map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", opts)
		map("n", "K", buf.hover, opts)
		map("n", "gi", buf.implementation, opts)
		map("n", "gI", "<cmd>FzfLua lsp_implementations<CR>", opts)
		map("n", "<C-k>", buf.signature_help, opts)
		map("n", "gt", buf.type_definition, opts)
		map("n", "gT", "<cmd>FzfLua lsp_typedefs<CR>", opts)
		map("n", "<leader>rn", buf.rename, opts)
		map({ "n", "v" }, "<leader>ca", buf.code_action, opts)
		-- map("n", "gr", buf.references, opts)
		map("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)
	end,
})
