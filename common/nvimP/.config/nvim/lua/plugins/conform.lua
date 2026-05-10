-- formatting
return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local conform = require("conform")

		local go_formatters = {}

		if vim.fn.executable("gofumpt") then
			table.insert(go_formatters, "gofumpt")
		end

		if vim.fn.executable("golines") then
			table.insert(go_formatters, "golines")
		end

		local python_formatters = {}

		if vim.fn.executable("isort") then
			table.insert(python_formatters, "isort")
		end

		if vim.fn.executable("black") then
			table.insert(python_formatters, "black")
		end

		conform.setup({
			formatters = {
				golines = {
					prepend_args = { "-m", "120" },
				},
			},

			formatters_by_ft = {
				lua = { "stylua" },

				sh = { "shfmt" },

				angular = { "prettierd" },
				css = { "prettierd" },
				flow = { "prettierd" },
				graphql = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				jsx = { "prettierd" },
				javascript = { "prettierd" },
				less = { "prettierd" },
				markdown = { "prettierd" },
				scss = { "prettierd" },
				typescript = { "prettierd" },
				vue = { "prettierd" },
				yaml = { "prettierd" },

				go = go_formatters,

				python = python_formatters,
			},

			default_format_opts = {
				lsp_format = "fallback",
				timeout_ms = 1000,
			},

			-- format_on_save = {},

			vim.keymap.set({ "n", "v" }, "<leader>f", conform.format),
		})
	end,
}
