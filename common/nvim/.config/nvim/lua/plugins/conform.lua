vim.pack.add({ gh("stevearc/conform.nvim") })

local fts_by_formatter = {
	oxfmt = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"vue",
		"css",
		"scss",
		"html",
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"graphql",
		"toml",
		"less",
	},

	prettier = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"htmlangular",
		"vue",
		"css",
		"less",
		"scss",
		"html",
		"handlebars",
		"json",
		"jsonc",
		"graphql",
		"markdown",
		"mdx",
		"yaml",
	},

	stylua = {
		"lua",
	},
}

local conform = require("conform")
local util = require("conform.util")

local formatters_by_ft = require("util").invert_index(fts_by_formatter)

conform.setup({
	formatters_by_ft = formatters_by_ft,

	formatters = {
		oxfmt = {
			command = util.find_executable({ "node_modules/.bin/oxfmt" }, "oxfmt"),
		},

		prettier = {
			command = util.find_executable({ "node_modules/.bin/prettier" }, "prettier"),
		},
	},

	default_format_opts = {
		timeout_ms = 1000,
		lsp_format = "never",
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "never",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", conform.format)
