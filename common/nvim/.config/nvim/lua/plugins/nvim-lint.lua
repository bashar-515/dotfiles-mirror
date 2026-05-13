vim.pack.add({ gh("mfussenegger/nvim-lint") })

local fts_by_linter = {
	oxlint = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},

	eslint = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},
}

local lint = require("lint")

lint.linters_by_ft = require("util").invert_index(fts_by_linter)

local function find_local_bin(relative_path)
	local local_bin = vim.fn.findfile(relative_path, vim.fn.getcwd() .. ";")
	return local_bin ~= "" and local_bin or nil
end

lint.linters.oxlint.cmd = function()
	return find_local_bin("node_modules/.bin/oxlint")
end
lint.linters.eslint.cmd = function()
	return find_local_bin("node_modules/.bin/eslint")
end

local function available_for(ft)
	local available = {}
	for _, name in ipairs(lint.linters_by_ft[ft] or {}) do
		local linter = lint.linters[name]
		local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
		if cmd then
			table.insert(available, name)
		end
	end
	return available
end

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,

	callback = function()
		lint.try_lint(available_for(vim.bo.filetype))
	end,

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint(vim.bo.filetype)
	end),
})
