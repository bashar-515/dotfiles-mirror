vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add {
  -- deps.
  gh "nvim-tree/nvim-web-devicons",

  gh "nvim-tree/nvim-tree.lua",
}

require"nvim-tree".setup {
  view = {
    relativenumber = true,
    adaptive_size = true,
  },

  git = { ignore = false },

  actions = {
    open_file = {
      window_picker = { enable = false },
    },
  },
}

local map = vim.keymap.set

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "" })
map("n", "<leader>E", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "" })
map("n", "<leader>c", "<cmd>NvimTreeCollapse<CR>", { desc = "" })
