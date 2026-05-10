-- search for files and strings throughout a directory
return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required dependency
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improves performance and allows for better fuzzy find behavior
		"nvim-treesitter/nvim-treesitter", -- required for `live_grep` and `find_string` to work
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- workaround for https://github.com/nvim-treesitter/nvim-treesitter/issues/7952
		local open_after_tree = function(prompt_bufnr)
			vim.defer_fn(function()
				actions.select_default(prompt_bufnr)
			end, 100) -- Delay allows filetype and plugins to settle before opening
		end

		-- current behavior: ignore '.git' directory, show hidden files and do not respect '.gitignore'
		telescope.setup({
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--no-ignore",
						"--iglob",
						"!.git",
						"--iglob",
						"!node_modules",
						"--iglob",
						"!.venv",
						"--iglob",
						"!.direnv",
						"--iglob",
						"!dist",
					},
				},
			},

			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never", -- required/default
					"--no-heading", -- required/default
					"--with-filename", -- required/default
					"--line-number", -- required/default
					"--column", -- required/default

					"--smart-case", -- default

					"--hidden",
					"--no-ignore",
					"--glob",
					"!{**/.git/*}",
					"--glob",
					"!{**/node_modules/*}",
					"--glob",
					"!{**/.venv/*}",
					"--glob",
					"!{**/.direnv/*}",
					"--glob",
					"!{**/dist/*}",
				},

				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<CR>"] = open_after_tree,
					},
					n = { ["<CR>"] = open_after_tree },
				},
			},
		})

		telescope.load_extension("fzf")

		local keymap = vim.keymap
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>ff", builtin.find_files, {})
		keymap.set("n", "<leader>fg", builtin.live_grep, {}) -- requires 'ripgrep' on system to work (and also 'nvim-treesitter')
		keymap.set("n", "<leader>fs", builtin.grep_string, {}) -- requires 'ripgrep' on system to work (and also 'nvim-treesitter')
		keymap.set("n", "<leader>fb", builtin.buffers, {})
	end,
}
