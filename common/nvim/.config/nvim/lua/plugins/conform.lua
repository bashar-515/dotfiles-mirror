vim.pack.add { gh "stevearc/conform.nvim" }

local fts_by_formatter = {
  oxfmt = {
    "javascript",
    "typescript",
    "javascriptreact",  -- React, Solid, Qwik, Preact, Lit, Alptine.js (Next.js, Nuxt, Remix, TanStack Start, React Router, React Native)
    "typescriptreact",
    "vue",
    "css",
    "scss",
    "html",
    "json",
    "jsonc",
    "yaml",
    "markdown",
    "graphql",
    "toml",
    "less",
  },
}

local conform = require "conform"
local util = require "conform.util"

local formatters_by_ft = require"util".invert_index(fts_by_formatter)

formatters_by_ft.dockerfile = { lsp_format = "last" }

conform.setup {
  formatters_by_ft = formatters_by_ft,

  formatters = {
    oxfmt = {
      command = util.find_executable({ "node_modules/oxfmt/bin/oxfmt" }, "oxfmt"),
    },
  },

  default_format_opts = {
		timeout_ms = 1000,
		lsp_format = "never",
	},

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "never"
  },
}

vim.keymap.set({ "n", "v" }, "<leader>f", conform.format)
