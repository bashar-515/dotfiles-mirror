vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"astro",
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"jsonc",
		"lua",
		"prisma",
		"svelte",
		"typescript",
		"typescriptreact",
	},

	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
})
