-- brew install fzf
--
-- OPTIONAL
-- [x] brew install fd
-- [x] brew install rg
-- [x] brew install bat
-- [x] brew install git-delta
-- [ ] brew install jj
-- [x] brew install chafa
vim.pack.add {
  -- deps.
  gh "nvim-tree/nvim-web-devicons",

  -- OPTIONAL
  -- gh "mfussenegger/nvim-dap",
  gh "nvim-treesitter/nvim-treesitter-context",
  gh "meanderingprogrammer/render-markdown.nvim",

  gh "ibhagwan/fzf-lua",
}

local fl = require"fzf-lua"

fl.setup {
  grep = { rg_opts = "--hidden -g '!.git/' " .. fl.defaults.grep.rg_opts }
}

fl.register_ui_select()

local map = vim.keymap.set

map("n", "<leader>ff", "<cmd>FzfLua files<CR>")
map("n", "<leader>/", "<cmd>FzfLua live_grep<CR>")

map("n", "<leader>rm", function() require"render-markdown".toggle() end)
