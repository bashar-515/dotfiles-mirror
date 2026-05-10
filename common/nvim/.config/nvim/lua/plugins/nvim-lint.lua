vim.pack.add { gh "mfussenegger/nvim-lint" }

local fts_by_linter = {
  oxlint = {
    "javascript",
    "typescript",
    "javascriptreact",  -- React, Solid, Qwik, Preact, Lit, Alptine.js (Next.js, Nuxt, Remix, TanStack Start, React Router, React Native)
    "typescriptreact",
    "vue",
  }
}

local lint = require"lint"

lint.linters_by_ft = require"util".invert_index(fts_by_linter)

lint.linters.oxlint.cmd = function()
  local local_bin = vim.fn.findfile("node_modules/oxlint/bin/oxlint", vim.fn.getcwd() .. ";")
  return local_bin ~= "" and local_bin or nil
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})
