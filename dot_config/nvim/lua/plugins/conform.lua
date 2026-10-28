vim.pack.add({ gh("stevearc/conform.nvim") })

local fts_by_formatter = {
	["clang-format"] = {
		"c",
	},

	gofumpt = {
		"go",
	},

	goimports = {
		"go",
	},

	oxfmt = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"less",
		"markdown",
		"scss",
		"toml",
		"typescript",
		"typescriptreact",
		"vue",
		"yaml",
	},

	prettier = {
		"astro",
		"css",
		"graphql",
		"handlebars",
		"html",
		"htmlangular",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"less",
		"markdown",
		"mdx",
		"scss",
		"svelte",
		"typescript",
		"typescriptreact",
		"vue",
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
		local pkg_jsons = vim.fs.find("package.json", { upward = true, path = start, limit = math.huge })
		for _, pkg_json in ipairs(pkg_jsons) do
			local ok, data = pcall(function() return vim.json.decode(table.concat(vim.fn.readfile(pkg_json), "\n")) end)
			if ok and type(data) == "table" then
				for _, field in ipairs({ "dependencies", "devDependencies", "peerDependencies", "optionalDependencies" }) do
					if data[field] and data[field][pkg] then
						return true
					end
				end
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
		timeout_ms = 1000,
		lsp_format = "never",
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function() conform.format({ async = true }) end)
