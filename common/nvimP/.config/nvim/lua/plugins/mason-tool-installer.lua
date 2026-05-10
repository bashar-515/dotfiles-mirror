-- automate the installation of linters and formatters through Mason
return {
	"whoissethdaniel/mason-tool-installer.nvim",

	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
                "prisma-language-server",

				-- Linter + LSP
				-- terraform
				"tflint",

				-- LSP's
				-- lua
				"lua_ls",

				-- go
				"gopls",

				-- bash, csh, ksh, sh, zsh
				"bashls",

				-- typescript, javascript
				"ts_ls",

				--protobuf
				"buf_ls",

				-- python
				"pyright",

				-- svelte
				"svelte-language-server",

				-- postgresql, sql
				"postgres-language-server",

				-- formatters
				-- lua, luau
				"stylua",

				-- bash
				"shfmt",

				-- angular, css, flow, graphql, html, json, jsx, javascript, less, markdown, scss, typescript, vue, yaml
				"prettierd",

				-- go
				"gofumpt",
				"golines",

				-- python
				"isort",

				-- terraform
				"terraform",

				-- linters
				-- lua
				"luacheck",

				-- bash
				"shellcheck",

				-- typescript, javascript
				"eslint_d",

				-- sql
				"sqlfluff",
			},

			auto_update = true,

			integrations = {
				["mason-lsp-config"] = true,
			},
		})
	end,
}
