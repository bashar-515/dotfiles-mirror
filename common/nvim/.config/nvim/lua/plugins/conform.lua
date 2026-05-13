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

local function is_direct_dep(pkg)
	return function(_, ctx)
		local start = ctx.filename and vim.fs.dirname(ctx.filename) or vim.uv.cwd()
		local pkg_json = vim.fs.find("package.json", { upward = true, path = start })[1]
		if not pkg_json then
			return false
		end
		local ok, data = pcall(function()
			return vim.json.decode(table.concat(vim.fn.readfile(pkg_json), "\n"))
		end)
		if not ok or type(data) ~= "table" then
			return false
		end
		for _, field in ipairs({ "dependencies", "devDependencies", "peerDependencies", "optionalDependencies" }) do
			if data[field] and data[field][pkg] then
				return true
			end
		end
		return false
	end
end

conform.setup({
	formatters_by_ft = formatters_by_ft,

	formatters = {
		oxfmt = {
			command = util.find_executable({ "node_modules/.bin/oxfmt" }, "oxfmt"),
			condition = is_direct_dep("oxfmt"),
		},

		prettier = {
			command = util.find_executable({ "node_modules/.bin/prettier" }, "prettier"),
			condition = is_direct_dep("prettier"),
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
