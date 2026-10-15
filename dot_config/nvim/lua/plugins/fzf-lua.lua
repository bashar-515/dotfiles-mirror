-- fzf - mise
--
-- OPTIONAL
-- [x] fd: mise
-- [x] rg: mise
-- [x] bat: mise
-- [x] git-delta: mise
-- [ ] jj
-- [x] chafa: brew
vim.pack.add({
	-- deps.
	gh("nvim-tree/nvim-web-devicons"),

	-- OPTIONAL
	-- gh "mfussenegger/nvim-dap",
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("meanderingprogrammer/render-markdown.nvim"),

	gh("ibhagwan/fzf-lua"),
})

local fl = require("fzf-lua")

fl.setup({
	fzf_opts = { ["--cycle"] = true },
	grep = { rg_opts = "--hidden -g '!.git/' " .. fl.defaults.grep.rg_opts },
	previewers = {
		builtin = {
			extensions = {
				["png"] = { "chafa", "{file}" },
				["jpg"] = { "chafa", "{file}" },
				["gif"] = { "chafa", "{file}" },
				["webp"] = { "chafa", "{file}" },
			},
		},
	},
})

fl.register_ui_select()

local rm = require("render-markdown")

rm.setup({ enabled = false })

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>/", "<cmd>FzfLua live_grep<CR>")

map("n", "<leader>rm", function()
	rm.toggle()
end)
