-- syntax highlighting
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",

	-- lazy load
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				-- _must_ be installed
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",

				-- optional
				"bash",
				"javascript",
				"typescript",
				"json",
				"dockerfile",
				"make",
				"gitignore",
				"go",
				"python",
				"svelte",
				"sql",
				"tsx",
                "prisma",
			},

			-- install parsers synchronously/sequentially (only applied to `ensure_installed`)
			sync_install = true,

			-- do not install automatically detected missing parser
			auto_install = true,

			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
