vim.pack.add { gh "mfussenegger/nvim-lint" }

local fts_by_linter = {
  oxlint = {
    "javascript",
    "typescript",
    "javascriptreact",  -- React, Solid, Qwik, Preact, Lit, Alptine.js (Next.js, Nuxt, Remix, TanStack Start, React Router, React Native)
    "typescriptreact",
    "vue",
  },

  eslint = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  }
}

local lint = require"lint"

lint.linters_by_ft = require"util".invert_index(fts_by_linter)

local function find_local_bin(relative_path)
  local local_bin = vim.fn.findfile(relative_path, vim.fn.getcwd() .. ";")
  return local_bin ~= "" and local_bin or nil
end

lint.linters.oxlint.cmd = find_local_bin "node_modules/.bin/oxlint"
lint.linters.eslint.cmd = find_local_bin "node_modules/.bin/eslint"

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,

  callback = function()
    lint.try_lint()
  end,

  vim.keymap.set("n", "<leader>l", function() lint.try_lint() end)
})
